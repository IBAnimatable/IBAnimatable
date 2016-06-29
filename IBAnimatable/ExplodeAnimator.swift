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
  
  // MARK: - private
  private var xFactor: CGFloat = 10.0
  private var minAngle: CGFloat = -10.0
  private var maxAngle: CGFloat = 10.0
  
  public init(params: [String], transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.transitionAnimationType = .explode(params: params)
    self.reverseAnimationType = .explode(params: params)
    
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
    
    let snapshots = createSnapshots(toView, fromView: fromView, containerView: containerView)
    containerView.sendSubview(toBack: fromView)
    animateSnapshotsExplode(snapshots) {
      if transitionContext.transitionWasCancelled() {
        containerView.bringSubview(toFront: fromView)
      }
      
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
}

private extension ExplodeAnimator {
  
  func createSnapshots(_ toView: UIView, fromView: UIView, containerView: UIView) -> [UIView] {
    let size = toView.frame.size
    var snapshots = [UIView]()
    let yFactor = xFactor * size.height / size.width
    
    let fromViewSnapshot = fromView.snapshotView(afterScreenUpdates: false)
    for x in stride(from: 0.0, to: Double(size.width), by: Double(size.width / xFactor)) {
      for y in stride(from: 0.0, to: Double(size.height), by: Double(size.width / yFactor)) {
        let snapshotRegion = CGRect(x: CGFloat(x), y: CGFloat(y), width: size.width / xFactor, height: size.height / yFactor)
        let snapshot = fromViewSnapshot?.resizableSnapshotView(from: snapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        snapshot?.frame = snapshotRegion
        containerView.addSubview(snapshot!)
        snapshots.append(snapshot!)
      }
    }
    return snapshots
  }
  
  func animateSnapshotsExplode(_ snapshots: [UIView], completion: AnimatableCompletion) {
    UIView.animate(withDuration: transitionDuration, animations: {
      snapshots.forEach {
        let xOffset = self.randomFloatBetween(-100.0, upper: 100.0)
        let yOffset = self.randomFloatBetween(-100.0, upper: 100.0)
        let angle = self.randomFloatBetween(self.minAngle, upper: self.maxAngle)

        let translateTransform = CGAffineTransform(translationX: $0.frame.origin.x - xOffset, y: $0.frame.origin.y - yOffset)
        let angleTransform = translateTransform.rotate(angle)
        let scaleTransform = angleTransform.scaleBy(x: 0.01, y: 0.01)
        
        $0.transform = scaleTransform
        $0.alpha = 0.0
      }
    },
    completion: { _ in
      snapshots.forEach { $0.removeFromSuperview() }
      completion()
    })
  }
  
  func randomFloatBetween(_ lower: CGFloat, upper: CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(upper - lower))) + lower
  }
  
}
