//
//  Created by Tom Baranes on 09/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class FoldAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType? = .Default
  
  // MARK: - Private params
  private var reverse: Bool = false
  private var folds: Int = 2
  
  // MARK: - Private fold transition
  private var transform: CATransform3D = CATransform3DIdentity
  private var size: CGSize = CGSize.zero
  private var foldWidth: CGFloat = 0.0
  
  // MARK: - Life cycle
  init(params: String, transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.transitionAnimationType = .Fold(params: params)
    self.reverseAnimationType = .Fold(params: params)
    
    let params = params.componentsSeparatedByString(",")
    if let unwrappedFolds = Int(params[0]) where params.count == 1 {
      self.folds = unwrappedFolds
    }
    super.init()
  }
}

extension FoldAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0)
    containerView.addSubview(toView)
    
    transform.m34 = -0.005
    containerView.layer.sublayerTransform = transform
    
    size = toView.frame.size
    foldWidth = size.width * 0.5 / CGFloat(folds)

    let viewFolds = createSnapshots(toView: toView, fromView: fromView, containerView: containerView)
    animateFoldTransition(fromView: fromView, toViewFolds: viewFolds[0], fromViewFolds: viewFolds[1]) {
      toView.frame = containerView.bounds;
      fromView.frame = containerView.bounds;
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
}

// MARK: - Setup fold transition

private extension FoldAnimator {
  
  func createSnapshots(toView toView: UIView, fromView: UIView, containerView: UIView) -> [[UIView]] {
    var fromViewFolds = [UIView]()
    var toViewFolds = [UIView]()
    for i in 0..<folds {
      let offset = CGFloat(i) * foldWidth * 2
      let leftFromViewFold = createSnapshot(fromView: fromView, afterUpdates: false, offset: offset, left: true)
      leftFromViewFold.layer.position = CGPoint(x: offset, y: size.height / 2)
      fromViewFolds.append(leftFromViewFold)
      leftFromViewFold.subviews[1].alpha = 0.0

      let rightFromViewFold = createSnapshot(fromView: fromView, afterUpdates: false, offset: offset + foldWidth, left: false)
      rightFromViewFold.layer.position = CGPoint(x: offset + foldWidth * 2, y: size.height / 2);
      fromViewFolds.append(rightFromViewFold)
      rightFromViewFold.subviews[1].alpha = 0.0

      let leftToViewFold = createSnapshot(fromView: toView, afterUpdates: true, offset: offset, left: true)
      leftToViewFold.layer.position = CGPointMake(self.reverse ? size.width : 0.0, size.height / 2)
      leftToViewFold.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 1.0, 0.0)
      toViewFolds.append(leftToViewFold)

      let rightToViewFold = createSnapshot(fromView: toView, afterUpdates: true, offset: offset + foldWidth, left: false)
      rightToViewFold.layer.position = CGPointMake(self.reverse ? size.width : 0.0, size.height / 2)
      rightToViewFold.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0.0, 1.0, 0.0)
      toViewFolds.append(rightToViewFold)
    }
    return [toViewFolds, fromViewFolds]
  }
  
  func createSnapshot(fromView view: UIView, afterUpdates: Bool, offset: CGFloat, left: Bool) -> UIView {
    let containerView = view.superview
    var snapshotView: UIView
    let snapshotRegion = CGRect(x: offset, y: 0.0, width: foldWidth, height: size.height)
    if !afterUpdates {
      snapshotView = view.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: afterUpdates, withCapInsets: UIEdgeInsetsZero)
    } else {
      snapshotView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: foldWidth, height: size.height))
      snapshotView.backgroundColor = view.backgroundColor;
      let subSnapshotView = view.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: afterUpdates, withCapInsets: UIEdgeInsetsZero)
      snapshotView.addSubview(subSnapshotView)
    }
    
    let snapshotWithShadowView = addShadow(toView: snapshotView, reverse: left)
    containerView?.addSubview(snapshotWithShadowView)
    snapshotWithShadowView.layer.anchorPoint = CGPoint(x: left ? 0.0 : 1.0, y: 0.5)
    return snapshotWithShadowView
  }
  
  func addShadow(toView view: UIView, reverse: Bool) -> UIView {
    let viewWithShadow = UIView(frame: view.frame)
    let shadowView = UIView(frame: viewWithShadow.bounds)
    let gradient = CAGradientLayer()
    gradient.frame = shadowView.bounds
    gradient.colors = [UIColor(white: 0.0, alpha: 0.0).CGColor, UIColor(white: 0.0, alpha: 1.0).CGColor]
    gradient.startPoint = CGPoint(x: reverse ? 0.0 : 1.0, y: reverse ? 0.2 : 0.0)
    gradient.endPoint = CGPoint(x: reverse ? 1.0 : 0.0, y: reverse ? 0.0 : 1.0)
    shadowView.layer.insertSublayer(gradient, atIndex: 1)
    
    view.frame = view.bounds
    viewWithShadow.addSubview(view)
    viewWithShadow.addSubview(shadowView)
    return viewWithShadow
  }

}

// MARK: - Animates

private extension FoldAnimator {

  func animateFoldTransition(fromView view: UIView, toViewFolds: [UIView], fromViewFolds: [UIView], completion: AnimatableCompletion) {
    view.frame = CGRectOffset(view.frame, view.frame.width, 0)
    UIView.animateWithDuration(transitionDuration, animations: {
      for i in 0..<self.folds {
        let offset = CGFloat(i) * self.foldWidth * 2
        let leftFromView = fromViewFolds[i * 2]
        leftFromView.layer.position = CGPoint(x: self.reverse ? 0.0 : self.size.width, y: self.size.height / 2)
        leftFromView.layer.transform = CATransform3DRotate(self.transform, CGFloat(M_PI_2), 0.0, 1.0, 0)
        leftFromView.subviews[1].alpha = 1.0
        
        let rightFromView = fromViewFolds[i * 2 + 1]
        rightFromView.layer.position = CGPoint(x: self.reverse ? 0.0 : self.size.width, y: self.size.height / 2)
        rightFromView.layer.transform = CATransform3DRotate(self.transform, CGFloat(-M_PI_2), 0.0, 1.0, 0)
        rightFromView.subviews[1].alpha = 1.0
        
        let leftToView = toViewFolds[i * 2]
        leftToView.layer.position = CGPoint(x: offset, y: self.size.height / 2)
        leftToView.layer.transform = CATransform3DIdentity
        leftToView.subviews[1].alpha = 0.0

        let rightToView = toViewFolds[i * 2 + 1]
        rightToView.layer.position = CGPoint(x: offset + self.foldWidth * 2, y: self.size.height / 2)
        rightToView.layer.transform = CATransform3DIdentity
        rightToView.subviews[1].alpha = 0.0
      }
    },
    completion: { _ in
      toViewFolds.forEach {
        $0.removeFromSuperview()
      }

      fromViewFolds.forEach {
        $0.removeFromSuperview()
      }
      
      completion()
    })
  }
  
}