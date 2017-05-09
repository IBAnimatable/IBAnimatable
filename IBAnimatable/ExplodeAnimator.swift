//
//  Created by Tom Baranes on 03/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ExplodeAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?

  // MARK: - private
  fileprivate var xFactor: CGFloat
  fileprivate var minAngle: CGFloat
  fileprivate var maxAngle: CGFloat

  public init(xFactor: CGFloat?, minAngle: CGFloat?, maxAngle: CGFloat?, duration: Duration) {
    transitionDuration = duration

    self.xFactor = xFactor ?? 10.0
    self.minAngle = minAngle ?? -10.0
    self.maxAngle = maxAngle ?? 10.0

    transitionAnimationType = .explode(xFactor: self.xFactor, minAngle: self.minAngle, maxAngle: self.maxAngle)
    reverseAnimationType = .explode(xFactor: self.xFactor, minAngle: self.minAngle, maxAngle: self.maxAngle)
    super.init()
  }
}

extension ExplodeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    guard let fromView = tempfromView, let toView = tempToView, let containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }

    containerView.insertSubview(toView, at: 0)

    let snapshots = makeSnapshots(toView: toView, fromView: fromView, containerView: containerView)
    containerView.sendSubview(toBack: fromView)
    animateSnapshotsExplode(snapshots) {
      if transitionContext.transitionWasCancelled {
        containerView.bringSubview(toFront: fromView)
      }

      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

}

private extension ExplodeAnimator {

  func makeSnapshots(toView: UIView, fromView: UIView, containerView: UIView) -> [UIView] {
    let size = toView.frame.size
    var snapshots = [UIView]()
    let yFactor = xFactor * size.height / size.width

    let fromViewSnapshot = fromView.snapshotView(afterScreenUpdates: false)
    for x in stride(from: 0.0, to: Double(size.width), by: Double(size.width / xFactor)) {
      for y in stride(from: 0.0, to: Double(size.height), by: Double(size.width / yFactor)) {
        let snapshotRegion = CGRect(x: CGFloat(x), y: CGFloat(y), width: size.width / xFactor, height: size.height / yFactor)
        let snapshot = fromViewSnapshot?.resizableSnapshotView(from: snapshotRegion, afterScreenUpdates: false, withCapInsets: .zero)
        snapshot?.frame = snapshotRegion
        containerView.addSubview(snapshot!)
        snapshots.append(snapshot!)
      }
    }
    return snapshots
  }

  func animateSnapshotsExplode(_ snapshots: [UIView], completion: @escaping AnimatableCompletion) {
    UIView.animate(withDuration: transitionDuration, animations: {
      snapshots.forEach {
        let xOffset = self.randomFloat(from: -100.0, to: 100.0)
        let yOffset = self.randomFloat(from: -100.0, to: 100.0)
        let angle = self.randomFloat(from: self.minAngle, to: self.maxAngle)

        let translateTransform = CGAffineTransform(translationX: $0.frame.origin.x - xOffset, y: $0.frame.origin.y - yOffset)
        let angleTransform = translateTransform.rotated(by: angle)
        let scaleTransform = angleTransform.scaledBy(x: 0.01, y: 0.01)

        $0.transform = scaleTransform
        $0.alpha = 0.0
      }
    },
    completion: { _ in
      snapshots.forEach { $0.removeFromSuperview() }
      completion()
    })
  }

  func randomFloat(from lower: CGFloat, to upper: CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(upper - lower))) + lower
  }

}
