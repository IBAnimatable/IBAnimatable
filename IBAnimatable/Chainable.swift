//
//  Chainable.swift
//  IBAnimatable
//
//  Created by jason akakpo on 01/01/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import Foundation
import UIKit

typealias AnimationTuple = (type: AnimationType, conf: AnimationConfiguration)

struct AnimationConfiguration {
  let damping: CGFloat
  let velocity: CGFloat
  let duration: Double
  let delay: Double
  let force: CGFloat

}


public class AnimationPromise<T: UIView where T: Animatable> {

  private var view: T
  private var animationList: [AnimationTuple] = []
  private var delayForNextAnim: Double = 0
  private var completion: AnimatableCompletion?

  internal init(view: T) {
    self.view = view
  }


  internal func animCompleted() {
      animationList.remove(at: 0)
      if let anim = animationList.first {
        view.doAnimation(animation: anim.type, configuration: anim.conf, promise: self)
      } else {
        completion?()
    }
  }


  public func completion(_ completion: AnimatableCompletion?) {
    self.completion = completion
  }

   @discardableResult public func  then(_ animation: AnimationType, duration: Double? = nil, damping: CGFloat? = nil, velocity: CGFloat? = nil, force: CGFloat? = nil) -> AnimationPromise {
    let animTuple = AnimationTuple(type: animation, conf: AnimationConfiguration(damping: damping ?? view.damping, velocity: velocity ?? view.velocity, duration: duration ?? view.duration, delay: delayForNextAnim, force: force ?? view.force))
    self.animationList.append(animTuple)
    if animationList.count == 1 { // If it's the first animation, launtch it immediately
      view.doAnimation(animation: animation, configuration: animTuple.conf, promise: self)
    }
    delayForNextAnim = 0
    return self
  }

  @discardableResult public func delay(_ delay: Double) -> AnimationPromise {
    delayForNextAnim = delay
    return self
  }
}
