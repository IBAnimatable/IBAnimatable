//
//  Created by Tom Baranes on 17/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PortalAnimator: NSObject, AnimatedTransitioning {

  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?

  // MARK: - private
  fileprivate var fromDirection: TransitionAnimationType.Direction
  fileprivate var zoomScale: CGFloat

  public init(from direction: TransitionAnimationType.Direction, zoomScale: CGFloat?, duration: Duration) {
    transitionDuration = duration
    fromDirection = direction
    self.zoomScale = zoomScale ?? 0.8
    transitionAnimationType = .portal(direction: direction, zoomScale: self.zoomScale)
    reverseAnimationType = .portal(direction: direction.opposite, zoomScale: self.zoomScale)
    interactiveGestureType = .pinch(direction: direction.opposingGesture)

    super.init()
  }
}

extension PortalAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    guard let fromView = tempfromView, let toView = tempToView, let containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }

    switch fromDirection {
    case .forward:
      executeForwardAnimation(transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    default:
      executeBackwardAnimation(transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    }
  }

}

// MARK: - Forward

private extension PortalAnimator {

  func executeForwardAnimation(transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {
    let toViewSnapshot = toView.resizableSnapshotView(from: toView.frame, afterScreenUpdates: true, withCapInsets: .zero)!
    let scale = CATransform3DIdentity
    toViewSnapshot.layer.transform = CATransform3DScale(scale, zoomScale, zoomScale, 1)
    containerView.insertSubview(toViewSnapshot, at: 0)

    let leftSnapshotRegion = CGRect(x: 0, y: 0, width: fromView.frame.width / 2, height: fromView.bounds.height)
    let leftHandView = fromView.resizableSnapshotView(from: leftSnapshotRegion, afterScreenUpdates: false, withCapInsets: .zero)!
    leftHandView.frame = leftSnapshotRegion
    containerView.addSubview(leftHandView)

    let rightSnapshotRegion = CGRect(x: fromView.frame.width / 2, y: 0, width: fromView.frame.width / 2, height: fromView.frame.height)
    let rightHandView = fromView.resizableSnapshotView(from: rightSnapshotRegion, afterScreenUpdates: false, withCapInsets: .zero)!
    rightHandView.frame = rightSnapshotRegion
    containerView.addSubview(rightHandView)

    fromView.isHidden = true

    UIView.animate(
      withDuration: transitionDuration,
      delay: 0.0,
      options: .curveEaseOut,
      animations: {
        leftHandView.frame = leftHandView.frame.offsetBy(dx: -leftHandView.frame.width, dy: 0.0)
        rightHandView.frame = rightHandView.frame.offsetBy(dx: rightHandView.frame.width, dy: 0.0)
        toViewSnapshot.center = toView.center
        toViewSnapshot.frame = containerView.frame
      },
      completion: { _ in
        fromView.isHidden = false
        if transitionContext.transitionWasCancelled {
          self.removeOtherViews(viewToKeep: fromView)
        } else {
          toView.frame = containerView.frame
          containerView.addSubview(toView)
          self.removeOtherViews(viewToKeep: toView)
        }
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    )
  }

}

// MARK: - Reverse

private extension PortalAnimator {

  func executeBackwardAnimation(transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {
    containerView.addSubview(fromView)
    toView.frame = toView.frame.offsetBy(dx: toView.frame.width, dy: 0)
    containerView.addSubview(toView)

    let leftSnapshotRegion = CGRect(x: 0, y: 0, width: toView.frame.width / 2, height: toView.bounds.height)
    let leftHandView = toView.resizableSnapshotView(from: leftSnapshotRegion, afterScreenUpdates: true, withCapInsets: .zero)!
    leftHandView.frame = leftSnapshotRegion
    leftHandView.frame = (leftHandView.frame.offsetBy(dx: -(leftHandView.frame.width), dy: 0))
    containerView.addSubview(leftHandView)

    let rightSnapshotRegion = CGRect(x: toView.frame.width / 2, y: 0, width: toView.frame.width / 2, height: fromView.frame.height)
    let rightHandView = toView.resizableSnapshotView(from: rightSnapshotRegion, afterScreenUpdates: true, withCapInsets: .zero)!
    rightHandView.frame = rightSnapshotRegion
    rightHandView.frame = (rightHandView.frame.offsetBy(dx: (rightHandView.frame.width), dy: 0))
    containerView.addSubview(rightHandView)

    UIView.animate(
      withDuration: transitionDuration,
      delay: 0.0,
      options: .curveEaseOut,
      animations: {
        leftHandView.frame = leftHandView.frame.offsetBy(dx: leftHandView.frame.size.width, dy: 0)
        rightHandView.frame = rightHandView.frame.offsetBy(dx: -rightHandView.frame.size.width, dy: 0)
        let scale = CATransform3DIdentity
        fromView.layer.transform = CATransform3DScale(scale, self.zoomScale, self.zoomScale, 1)
      },
      completion: { _ in
        if transitionContext.transitionWasCancelled {
          self.removeOtherViews(viewToKeep: fromView)
        } else {
          self.removeOtherViews(viewToKeep: toView)
          toView.frame = containerView.bounds
          fromView.layer.transform = CATransform3DIdentity
        }
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    )
  }

}

// MARK: - Helper

private extension PortalAnimator {

  func removeOtherViews(viewToKeep: UIView) {
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
