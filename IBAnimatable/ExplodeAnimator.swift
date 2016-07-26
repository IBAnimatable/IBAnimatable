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
  private var xFactor: CGFloat = 10.0
  private var minAngle: CGFloat = -10.0
  private var maxAngle: CGFloat = 10.0
  
  public init(params: [String], transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.transitionAnimationType = .Explode(params: params)
    self.reverseAnimationType = .Explode(params: params)
    
    if params.count == 3 {
      if let unwrappedXFactor = Double(params[0]),
             unwrappedMinAngle = Double(params[1]),
             unwrappedMaxAngle = Double(params[2]) {
        self.xFactor = CGFloat(unwrappedXFactor)
        self.minAngle = CGFloat(unwrappedMinAngle)
        self.maxAngle = CGFloat(unwrappedMaxAngle)
      }
    }
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
    
    containerView.insertSubview(toView, atIndex: 0)
    
    let snapshots = createSnapshots(toView: toView, fromView: fromView, containerView: containerView)
    containerView.sendSubviewToBack(fromView)
    animateSnapshotsExplode(snapshots) {
      if transitionContext.transitionWasCancelled() {
        containerView.bringSubviewToFront(fromView)
      }
      
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
}

private extension ExplodeAnimator {
  
  func createSnapshots(toView toView: UIView, fromView: UIView, containerView: UIView) -> [UIView] {
    let size = toView.frame.size
    var snapshots = [UIView]()
    let yFactor = xFactor * size.height / size.width
    
    let fromViewSnapshot = fromView.snapshotViewAfterScreenUpdates(false)
    for x in 0.0.stride(to: Double(size.width), by: Double(size.width / xFactor)) {
      for y in 0.0.stride(to: Double(size.height), by: Double(size.width / yFactor)) {
        let snapshotRegion = CGRect(x: CGFloat(x), y: CGFloat(y), width: size.width / xFactor, height: size.height / yFactor)
        let snapshot = fromViewSnapshot.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        snapshot.frame = snapshotRegion
        containerView.addSubview(snapshot)
        snapshots.append(snapshot)
      }
    }
    return snapshots
  }
  
  func animateSnapshotsExplode(snapshots: [UIView], completion: AnimatableCompletion) {
    UIView.animateWithDuration(transitionDuration, animations: {
      snapshots.forEach {
        let xOffset = self.randomFloatBetween(lower: -100.0, upper: 100.0)
        let yOffset = self.randomFloatBetween(lower: -100.0, upper: 100.0)
        let angle = self.randomFloatBetween(lower: self.minAngle, upper: self.maxAngle)

        let translateTransform = CGAffineTransformMakeTranslation($0.frame.origin.x - xOffset, $0.frame.origin.y - yOffset)
        let angleTransform = CGAffineTransformRotate(translateTransform, angle)
        let scaleTransform = CGAffineTransformScale(angleTransform, 0.01, 0.01)
        
        $0.transform = scaleTransform
        $0.alpha = 0.0
      }
    },
    completion: { _ in
      snapshots.forEach { $0.removeFromSuperview() }
      completion()
    })
  }
  
  func randomFloatBetween(lower lower: CGFloat, upper: CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(upper - lower))) + lower
  }
  
}
