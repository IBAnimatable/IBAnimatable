//
//  ExplodeAnimator.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 03/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class ExplodeAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.transitionAnimationType = .Explode
    self.reverseAnimationType = .Explode
    super.init()
  }
}

extension ExplodeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    containerView.addSubview(toView)
    containerView.sendSubviewToBack(toView)
    
    let size = toView.frame.size
    var snapshots = [UIView]()
    let xFactor: CGFloat = 10.0
    let yFactor = xFactor * size.height / size.width

    let fromViewSnapshot = fromView.snapshotViewAfterScreenUpdates(false)
    for x in 0.stride(to: Int(size.width), by: Int(size.width / xFactor)) {
      for y in 0.stride(to: Int(size.height), by: Int(size.width / yFactor)) {
        let snapshotRegion = CGRect(x: CGFloat(x), y: CGFloat(y), width: size.width / xFactor, height: size.height / yFactor)
        let snapshot = fromViewSnapshot.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        snapshot.frame = snapshotRegion
        containerView.addSubview(snapshot)
        snapshots.append(snapshot)
      }
    }

    containerView.sendSubviewToBack(fromView)
    UIView.animateWithDuration(transitionDuration, animations: {
      for view in snapshots {
        let xOffset = self.randomFloatBetween(lower: -100.0, upper: 100.0)
        let yOffset = self.randomFloatBetween(lower: -100.0, upper: 100.0)
        view.frame = CGRectOffset(view.frame, xOffset, yOffset)
        view.alpha = 0.0
        
        let angle = self.randomFloatBetween(lower: -10.0, upper: 10.0)
        view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 1.0, 1.0)
      }
      }) { _ in
        for view in snapshots {
          view.removeFromSuperview()
        }
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
  private func randomFloatBetween(lower lower: CGFloat, upper: CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(upper - lower))) + lower
  }
  
}