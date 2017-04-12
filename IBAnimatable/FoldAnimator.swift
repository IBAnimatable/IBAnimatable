//
//  Created by Tom Baranes on 09/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class FoldAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?

  // MARK: - Private params
  fileprivate var fromDirection: TransitionAnimationType.Direction
  fileprivate var folds: Int

  // MARK: - Private fold transition
  fileprivate var transform: CATransform3D = CATransform3DIdentity
  fileprivate var reverse: Bool = false
  fileprivate var horizontal: Bool = false
  fileprivate var size: CGSize = .zero
  fileprivate var foldSize: CGFloat = 0.0
  fileprivate var width: CGFloat {
      return horizontal ? size.width : size.height
  }
  fileprivate var height: CGFloat {
    return horizontal ? size.height : size.width
  }

  // MARK: - Life cycle
  public init(from direction: TransitionAnimationType.Direction, folds: Int?, duration: Duration) {
    fromDirection = direction
    horizontal = fromDirection.isHorizontal

    transitionDuration = duration
    self.folds = folds ?? 2

    transitionAnimationType = .fold(from: direction, folds: folds)
    reverseAnimationType = .fold(from: direction.opposite, folds: folds)
    interactiveGestureType = .pan(from: direction.opposingGesture)
    reverse = direction == .right || direction == .bottom

    super.init()
  }
}

extension FoldAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    guard let fromView = tempfromView, let toView = tempToView, let containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }

    toView.frame = toView.frame.offsetBy(dx: toView.frame.size.width, dy: 0)
    containerView.addSubview(toView)

    transform.m34 = -0.005
    containerView.layer.sublayerTransform = transform

    size = toView.frame.size
    foldSize = width * 0.5 / CGFloat(folds)

    let viewFolds = makeSnapshots(toView: toView, fromView: fromView, containerView: containerView)
    animateFoldTransition(fromView: fromView, toViewFolds: viewFolds[0], fromViewFolds: viewFolds[1], completion: {
      if !transitionContext.transitionWasCancelled {
        toView.frame = containerView.bounds
        fromView.frame = containerView.bounds
      } else {
        fromView.frame = containerView.bounds
      }

      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    )
  }

}

// MARK: - Setup fold transition

private extension FoldAnimator {

  func makeSnapshots(toView: UIView, fromView: UIView, containerView: UIView) -> [[UIView]] {
    var fromViewFolds = [UIView]()
    var toViewFolds = [UIView]()
    for i in 0..<folds {
      let offset = CGFloat(i) * foldSize * 2
      let leftFromViewFold = makeSnapshot(from: fromView, afterUpdates: false, offset: offset, left: true)
      var axesValues = valuesForAxe(initialValue: offset, reverseValue: height / 2)
      leftFromViewFold.layer.position = CGPoint(x: axesValues.0, y: axesValues.1)
      fromViewFolds.append(leftFromViewFold)
      leftFromViewFold.subviews[1].alpha = 0.0

      let rightFromViewFold = makeSnapshot(from: fromView, afterUpdates: false, offset: offset + foldSize, left: false)
      axesValues = valuesForAxe(initialValue: offset + foldSize * 2, reverseValue: height / 2)
      rightFromViewFold.layer.position = CGPoint(x: axesValues.0, y: axesValues.1)
      fromViewFolds.append(rightFromViewFold)
      rightFromViewFold.subviews[1].alpha = 0.0

      let leftToViewFold = makeSnapshot(from: toView, afterUpdates: true, offset: offset, left: true)
      axesValues = valuesForAxe(initialValue: reverse ? width : 0.0, reverseValue: height / 2)
      leftToViewFold.layer.position = CGPoint(x: axesValues.0, y: axesValues.1)
      axesValues = valuesForAxe(initialValue: 0.0, reverseValue: 1.0)
      leftToViewFold.layer.transform = CATransform3DMakeRotation(.pi / 2, axesValues.0, axesValues.1, 0.0)
      toViewFolds.append(leftToViewFold)

      let rightToViewFold = makeSnapshot(from: toView, afterUpdates: true, offset: offset + foldSize, left: false)
      axesValues = valuesForAxe(initialValue: reverse ? width : 0.0, reverseValue: height / 2)
      rightToViewFold.layer.position = CGPoint(x: axesValues.0, y: axesValues.1)
      axesValues = valuesForAxe(initialValue: 0.0, reverseValue: 1.0)
      rightToViewFold.layer.transform = CATransform3DMakeRotation(-.pi / 2, axesValues.0, axesValues.1, 0.0)
      toViewFolds.append(rightToViewFold)
    }
    return [toViewFolds, fromViewFolds]
  }

  func makeSnapshot(from view: UIView, afterUpdates: Bool, offset: CGFloat, left: Bool) -> UIView {
    let containerView = view.superview
    var snapshotView: UIView
    var axesValues = valuesForAxe(initialValue: offset, reverseValue: 0.0)
    let axesValues2 = valuesForAxe(initialValue: foldSize, reverseValue: height)
    let snapshotRegion = CGRect(x: axesValues.0, y: axesValues.1, width: axesValues2.0, height: axesValues2.1)
    if !afterUpdates {
      snapshotView = view.resizableSnapshotView(from: snapshotRegion, afterScreenUpdates: afterUpdates, withCapInsets: .zero)!
    } else {
      axesValues = valuesForAxe(initialValue: foldSize, reverseValue: height)
      snapshotView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: axesValues.0, height: axesValues.1))
      snapshotView.backgroundColor = view.backgroundColor
      let subSnapshotView = view.resizableSnapshotView(from: snapshotRegion, afterScreenUpdates: afterUpdates, withCapInsets: .zero)
      snapshotView.addSubview(subSnapshotView!)
    }

    let snapshotWithShadowView = addShadow(to: snapshotView, reverse: left)
    containerView?.addSubview(snapshotWithShadowView)
    axesValues = valuesForAxe(initialValue: left ? 0.0 : 1.0, reverseValue: 0.5)
    snapshotWithShadowView.layer.anchorPoint = CGPoint(x: axesValues.0, y: axesValues.1)
    return snapshotWithShadowView
  }

  func addShadow(to view: UIView, reverse: Bool) -> UIView {
    let viewWithShadow = UIView(frame: view.frame)
    let shadowView = UIView(frame: viewWithShadow.bounds)
    let gradient = CAGradientLayer()
    gradient.frame = shadowView.bounds
    // swiftlint:disable:next object_literal
    gradient.colors = [UIColor(white: 0.0, alpha: 0.0).cgColor, UIColor(white: 0.0, alpha: 1.0).cgColor]
    if horizontal {
      var axesValues = valuesForAxe(initialValue: reverse ? 0.0 : 1.0, reverseValue: reverse ? 0.2 : 0.0)
      gradient.startPoint = CGPoint(x: axesValues.0, y: axesValues.1)
      axesValues = valuesForAxe(initialValue: reverse ? 1.0 : 0.0, reverseValue: reverse ? 0.0 : 1.0)
      gradient.endPoint = CGPoint(x: axesValues.0, y: axesValues.1)
    } else {
      var axesValues = valuesForAxe(initialValue: reverse ? 0.2 : 0.0, reverseValue: reverse ? 0.0 : 1.0)
      gradient.startPoint = CGPoint(x: axesValues.0, y: axesValues.1)
      axesValues = valuesForAxe(initialValue: reverse ? 0.0 : 1.0, reverseValue: reverse ? 1.0 : 0.0)
      gradient.endPoint = CGPoint(x: axesValues.0, y: axesValues.1)
    }
    shadowView.layer.insertSublayer(gradient, at: 1)

    view.frame = view.bounds
    viewWithShadow.addSubview(view)
    viewWithShadow.addSubview(shadowView)
    return viewWithShadow
  }

}

// MARK: - Animates

private extension FoldAnimator {

  func animateFoldTransition(fromView view: UIView, toViewFolds: [UIView], fromViewFolds: [UIView], completion: @escaping AnimatableCompletion) {
    view.frame = view.frame.offsetBy(dx: view.frame.width, dy: 0)
    UIView.animate(withDuration: transitionDuration, animations: {
      for i in 0..<self.folds {
        let offset = CGFloat(i) * self.foldSize * 2
        let leftFromView = fromViewFolds[i * 2]
        var axesValues = self.valuesForAxe(initialValue: self.reverse ? 0.0 : self.width, reverseValue: self.height / 2)
        leftFromView.layer.position = CGPoint(x: axesValues.0, y: axesValues.1)
        axesValues = self.valuesForAxe(initialValue: 0.0, reverseValue: 1.0)
        leftFromView.layer.transform = CATransform3DRotate(self.transform, .pi / 2, axesValues.0, axesValues.1, 0)
        leftFromView.subviews[1].alpha = 1.0

        let rightFromView = fromViewFolds[i * 2 + 1]
        axesValues = self.valuesForAxe(initialValue: self.reverse ? 0.0 : self.width, reverseValue: self.height / 2)
        rightFromView.layer.position = CGPoint(x: axesValues.0, y: axesValues.1)
        axesValues = self.valuesForAxe(initialValue: 0.0, reverseValue: 1.0)
        rightFromView.layer.transform = CATransform3DRotate(self.transform, -.pi / 2, axesValues.0, axesValues.1, 0)
        rightFromView.subviews[1].alpha = 1.0

        let leftToView = toViewFolds[i * 2]
        axesValues = self.valuesForAxe(initialValue: offset, reverseValue: self.height / 2)
        leftToView.layer.position = CGPoint(x: axesValues.0, y: axesValues.1)
        leftToView.layer.transform = CATransform3DIdentity
        leftToView.subviews[1].alpha = 0.0

        let rightToView = toViewFolds[i * 2 + 1]
        axesValues = self.valuesForAxe(initialValue: offset + self.foldSize * 2, reverseValue: self.height / 2)
        rightToView.layer.position = CGPoint(x: axesValues.0, y: axesValues.1)
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

// MARK: - Helpers

private extension FoldAnimator {

  func valuesForAxe(initialValue: CGFloat, reverseValue: CGFloat) -> (CGFloat, CGFloat) {
    return horizontal ? (initialValue, reverseValue) : (reverseValue, initialValue)
  }

}
