//
//  Created by Tom Baranes on 17/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PortalAnimator: NSObject, AnimatedTransitioning {

  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var fromDirection: TransitionDirection
  private var zoomScale: CGFloat = 0.8
  
  public init(fromDirection: TransitionDirection, params: [String], transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.fromDirection = fromDirection
    
    if let firstParam = params.first,
           unwrappedZoomScale = Double(firstParam) {
      zoomScale = CGFloat(unwrappedZoomScale)
    }
    
    switch fromDirection {
    case .forward:
      self.transitionAnimationType = .portal(direction: .forward, params: params)
      self.reverseAnimationType = .portal(direction: .backward, params: params)
      self.interactiveGestureType = .pinch(direction: .Close)
    default:
      self.transitionAnimationType = .portal(direction: .backward, params: params)
      self.reverseAnimationType = .portal(direction: .forward, params: params)
      self.interactiveGestureType = .pinch(direction: .Open)
    }

    super.init()
  }
}

extension PortalAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    switch fromDirection {
    case .forward:
      executeForwardAnimation(transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    default:
      executeBackwardAnimation(transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    }
  }
  
}

// MARK: - Forward

private extension PortalAnimator {

  func executeForwardAnimation(_ transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {
    let toViewSnapshot = toView.resizableSnapshotView(from: toView.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)!
    let scale = CATransform3DIdentity
    toViewSnapshot.layer.transform = CATransform3DScale(scale, zoomScale, zoomScale, 1)
    containerView.insertSubview(toViewSnapshot, at: 0)

    let leftSnapshotRegion = CGRect(x: 0, y: 0, width: fromView.frame.width / 2, height: fromView.bounds.height)
    let leftHandView = fromView.resizableSnapshotView(from: leftSnapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)!
    leftHandView.frame = leftSnapshotRegion
    containerView.addSubview(leftHandView)

    let rightSnapshotRegion = CGRect(x: fromView.frame.width / 2, y: 0, width: fromView.frame.width / 2, height: fromView.frame.height)
    let rightHandView = fromView.resizableSnapshotView(from: rightSnapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)!
    rightHandView.frame = rightSnapshotRegion
    containerView.addSubview(rightHandView)
    
    fromView.isHidden = true

    UIView.animate(withDuration: transitionDuration, delay: 0.0, options: .curveEaseOut,
      animations: {
        leftHandView.frame = leftHandView.frame.offsetBy(dx: -leftHandView.frame.width, dy: 0.0)
        rightHandView.frame = rightHandView.frame.offsetBy(dx: rightHandView.frame.width, dy: 0.0)
        toViewSnapshot.center = toView.center
        toViewSnapshot.frame = containerView.frame
      },
      completion: { _ in
        fromView.isHidden = false
        if transitionContext.transitionWasCancelled() {
          self.removeOtherViews(fromView)
        } else {
          toView.frame = containerView.frame
          containerView.addSubview(toView)
          self.removeOtherViews(toView)
        }
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
      }
    )
  }
  
}

// MARK: - Reverse

private extension PortalAnimator {
  
  func executeBackwardAnimation(_ transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {
    containerView.addSubview(fromView)
    toView.frame = toView.frame.offsetBy(dx: toView.frame.width, dy: 0)
    containerView.addSubview(toView)

    let leftSnapshotRegion = CGRect(x: 0, y: 0, width: toView.frame.width / 2, height: toView.bounds.height)
    let leftHandView = toView.resizableSnapshotView(from: leftSnapshotRegion, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)!
    leftHandView.frame = leftSnapshotRegion
    leftHandView.frame = (leftHandView.frame.offsetBy(dx: -(leftHandView.frame.width), dy: 0))
    containerView.addSubview(leftHandView)

    let rightSnapshotRegion = CGRect(x: toView.frame.width / 2, y: 0, width: toView.frame.width / 2, height: fromView.frame.height)
    let rightHandView = toView.resizableSnapshotView(from: rightSnapshotRegion, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)!
    rightHandView.frame = rightSnapshotRegion
    rightHandView.frame = (rightHandView.frame.offsetBy(dx: (rightHandView.frame.width), dy: 0))
    containerView.addSubview(rightHandView)

    UIView.animate(withDuration: transitionDuration, delay: 0.0, options: .curveEaseOut,
      animations: {
        leftHandView.frame = leftHandView.frame.offsetBy(dx: leftHandView.frame.size.width, dy: 0)
        rightHandView.frame = rightHandView.frame.offsetBy(dx: -rightHandView.frame.size.width, dy: 0)
        let scale = CATransform3DIdentity
        fromView.layer.transform = CATransform3DScale(scale, self.zoomScale, self.zoomScale, 1)
      },
      completion: { _ in
        if transitionContext.transitionWasCancelled() {
          self.removeOtherViews(fromView)
        } else {
          self.removeOtherViews(toView)
          toView.frame = containerView.bounds
          fromView.layer.transform = CATransform3DIdentity
        }
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
      }
    )
  }
  
}

// MARK: - Helper

private extension PortalAnimator {
  
  func removeOtherViews(_ viewToKeep: UIView) {
    guard let containerView = viewToKeep.superview else {
      return
    }
    
    containerView.subviews.forEach {
      if $0 != viewToKeep {
        $0.removeFromSuperview()
      }
    }
  }
  
}
