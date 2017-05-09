//
//  Created by jason akakpo on 01/01/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import Foundation
import UIKit

typealias AnimationTuple = (type: AnimationType, configuration: AnimationConfiguration)

struct AnimationConfiguration {
  let damping: CGFloat
  let velocity: CGFloat
  let duration: TimeInterval
  let delay: TimeInterval
  let force: CGFloat
}

public class AnimationPromise<T: UIView> where T: Animatable {

  private var view: T
  private var animationList = [AnimationTuple]()
  private var delayForNextAnimation = 0.0
  private var completion: AnimatableCompletion?

  init(view: T) {
    self.view = view
  }

   func animationCompleted() {
      animationList.removeFirst()
      if let currentAnimation = animationList.first {
        view.doAnimation(currentAnimation.type, configuration: currentAnimation.configuration, promise: self)
      } else {
        completion?()
    }
  }

  public func completion(_ completion: AnimatableCompletion?) {
    self.completion = completion
  }

  @discardableResult
  public func  then(_ animation: AnimationType,
                    duration: TimeInterval? = nil,
                    damping: CGFloat? = nil,
                    velocity: CGFloat? = nil,
                    force: CGFloat? = nil) -> AnimationPromise {
    let configuration = AnimationConfiguration(damping: damping ?? view.damping,
                                               velocity: velocity ?? view.velocity,
                                               duration: duration ?? view.duration,
                                               delay: delayForNextAnimation,
                                               force: force ?? view.force)
    let animTuple = AnimationTuple(type: animation, configuration: configuration)
    animationList.append(animTuple)
    if animationList.count == 1 { // If it's the only animation, launch it immediately
      view.doAnimation(animation, configuration: animTuple.configuration, promise: self)
    }
    delayForNextAnimation = 0
    return self
  }

  @discardableResult
  public func delay(_ delay: TimeInterval) -> AnimationPromise {
    delayForNextAnimation = delay
    return self
  }
}
