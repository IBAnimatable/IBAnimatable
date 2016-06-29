//
//  Created by Tom Baranes on 05/05/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class FlipAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - Private params
  private var fromDirection: TransitionDirection
  
  // MARK: - Private fold transition
  private var transform: CATransform3D = CATransform3DIdentity
  private var reverse: Bool = false
  private var horizontal: Bool = false
  
  // MARK: - Life cycle
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    horizontal = fromDirection.isHorizontal
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .flip(fromDirection: .right)
      self.reverseAnimationType = .flip(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .Left)
      reverse = true
    default:
      self.transitionAnimationType = .flip(fromDirection: .left)
      self.reverseAnimationType = .flip(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .Right)
      reverse = false      
    }
    super.init()
  }
}

extension FlipAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    containerView.insertSubview(toView, at: 0)
    
    transform.m34 = -0.002
    containerView.layer.sublayerTransform = transform
    toView.frame = fromView.frame
    
    let flipViews = createSnapshots(toView, fromView: fromView, containerView: containerView)
    animateFlipTransition(flipViews.0, flippedSectionOfToView: flipViews.1) {
      if transitionContext.transitionWasCancelled() {
        self.removeOtherViews(fromView)
      } else {
        self.removeOtherViews(toView)
      }
      
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
}

// MARK: - Setup flip transition

private extension FlipAnimator {
  
  func createSnapshots(_ toView: UIView, fromView: UIView, containerView: UIView) -> ((UIView, UIView), (UIView, UIView)) {
    let toViewSnapshots = createSnapshot(fromView: toView, afterUpdates: true)
    var flippedSectionOfToView = toViewSnapshots[reverse ? 0 : 1]

    let fromViewSnapshots = createSnapshot(fromView: fromView, afterUpdates: false)
    var flippedSectionOfFromView = fromViewSnapshots[reverse ? 1 : 0]

    flippedSectionOfFromView = addShadow(toView: flippedSectionOfFromView, reverse: !reverse)
    let flippedSectionOfFromViewShadow = flippedSectionOfFromView.subviews[1]
    flippedSectionOfFromViewShadow.alpha = 0.0

    flippedSectionOfToView = addShadow(toView: flippedSectionOfToView, reverse:reverse)
    let flippedSectionOfToViewShadow = flippedSectionOfToView.subviews[1]
    flippedSectionOfToViewShadow.alpha = 1.0

    var axesValues = valuesForAxe(reverse ? 0.0 : 1.0, reverseValue: 0.5)
    updateAnchorPointAndOffset(CGPoint(x: axesValues.0, y: axesValues.1), view: flippedSectionOfFromView)
    axesValues = valuesForAxe(reverse ? 1.0 : 0.0, reverseValue: 0.5)
    updateAnchorPointAndOffset(CGPoint(x: axesValues.0, y: axesValues.1), view: flippedSectionOfToView)
    
    flippedSectionOfToView.layer.transform = rotate(reverse ? M_PI_2 : -M_PI_2)
    return ((flippedSectionOfFromView, flippedSectionOfFromViewShadow), (flippedSectionOfToView, flippedSectionOfToViewShadow))
  }
  
  func createSnapshot(fromView view: UIView, afterUpdates: Bool) -> [UIView] {
    let containerView = view.superview

    let width = valuesForAxe(view.frame.size.width / 2, reverseValue: view.frame.size.width)
    let height = valuesForAxe(view.frame.size.height, reverseValue: view.frame.size.height / 2)
    var snapshotRegion = CGRect(x: 0, y: 0, width: width.0, height: height.0)
    let leftHandView = view.resizableSnapshotView(from: snapshotRegion, afterScreenUpdates: afterUpdates, withCapInsets: UIEdgeInsetsZero)
    leftHandView?.frame = snapshotRegion
    containerView?.addSubview(leftHandView!)

    let x = valuesForAxe(view.frame.size.width / 2, reverseValue: 0)
    let y = valuesForAxe(0, reverseValue: view.frame.size.height / 2)
    snapshotRegion = CGRect(x: x.0, y: y.0, width: width.0, height: height.0)
    let rightHandView = view.resizableSnapshotView(from: snapshotRegion, afterScreenUpdates: afterUpdates, withCapInsets: UIEdgeInsetsZero)
    rightHandView?.frame = snapshotRegion
    containerView?.addSubview(rightHandView!)

    containerView?.sendSubview(toBack: view)
    return [leftHandView!, rightHandView!]
  }
  
  func addShadow(toView view: UIView, reverse: Bool) -> UIView {
    let containerView = view.superview
    let viewWithShadow = UIView(frame: view.frame)
    containerView?.insertSubview(viewWithShadow, aboveSubview: view)
    view.removeFromSuperview()

    let shadowView = UIView(frame: viewWithShadow.bounds)
    let gradient = CAGradientLayer()
    gradient.frame = shadowView.bounds
    gradient.colors = [UIColor(white: 0.0, alpha: 0.0), UIColor(white: 0.0, alpha: 0.5)]
    if horizontal {
      var axesValues = valuesForAxe(reverse ? 0.0 : 1.0, reverseValue: reverse ? 0.2 : 0.0)
      gradient.startPoint = CGPoint(x: axesValues.0, y: axesValues.1)
      axesValues = valuesForAxe(reverse ? 1.0 : 0.0, reverseValue: reverse ? 0.0 : 1.0)
      gradient.endPoint = CGPoint(x: axesValues.0, y: axesValues.1)
    } else {
      var axesValues = valuesForAxe(reverse ? 0.2 : 0.0, reverseValue: reverse ? 0.0 : 1.0)
      gradient.startPoint = CGPoint(x: axesValues.0, y: axesValues.1)
      axesValues = valuesForAxe(reverse ? 0.0 : 1.0, reverseValue: reverse ? 1.0 : 0.0)
      gradient.endPoint = CGPoint(x: axesValues.0, y: axesValues.1)
    }
        
    shadowView.layer.insertSublayer(gradient, at: 1)
    view.frame = view.bounds
    viewWithShadow.addSubview(view)
    viewWithShadow.addSubview(shadowView)
    return viewWithShadow
  }
  
  func updateAnchorPointAndOffset(_ anchorPoint: CGPoint, view: UIView) {
    view.layer.anchorPoint = anchorPoint
    if horizontal {
      let xOffset =  anchorPoint.x - 0.5
      view.frame = view.frame.offsetBy(dx: xOffset * view.frame.size.width, dy: 0)
    } else {
      let yOffset =  anchorPoint.y - 0.5
      view.frame = view.frame.offsetBy(dx: 0, dy: yOffset * view.frame.size.height)
    }
  }

  func rotate(_ angle: Double) -> CATransform3D {
    let axesValues = valuesForAxe(0.0, reverseValue: 1.0)    
    return  CATransform3DMakeRotation(CGFloat(angle), axesValues.0, axesValues.1, 0.0)
  }
  
}

// MARK: - Animates

private extension FlipAnimator {
  
  func animateFlipTransition(_ flippedSectionOfFromView: (UIView, UIView), flippedSectionOfToView: (UIView, UIView), completion: AnimatableCompletion) {
    UIView.animateKeyframes(withDuration: transitionDuration, delay: 0, options: .layoutSubviews, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: { 
        flippedSectionOfFromView.0.layer.transform = self.rotate(self.reverse ? -M_PI_2 : M_PI_2)
        flippedSectionOfFromView.1.alpha = 1.0
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
        flippedSectionOfToView.0.layer.transform = self.rotate(self.reverse ? 0.001 : -0.001)
        flippedSectionOfToView.1.alpha = 0.0
      })
    }) { _ in
      completion()
    }
  }
  
}

// MARK: - Helpers

private extension FlipAnimator {
 
  func removeOtherViews(_ viewToKeep: UIView) {
    let containerView = viewToKeep.superview
    containerView?.subviews.forEach {
      if $0 != viewToKeep {
        $0.removeFromSuperview()
      }
    }
  }
  
  func valuesForAxe(_ initialValue: CGFloat, reverseValue: CGFloat) -> (CGFloat, CGFloat) {
    return horizontal ? (initialValue, reverseValue) : (reverseValue, initialValue)
  }
  
}
