//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

/**
 TransitionPresenter Manager: Used to cache the Presenters for Present and Dismiss transitions
 */
public class TransitionPresenterManager {
  // MARK: - Singleton Constructor
  private init() {}
  private struct Shared {
    static let instance = TransitionPresenterManager()
  }
  
  public static func sharedManager() -> TransitionPresenterManager {
    return Shared.instance
  }
  
  // MARK: - Private
  private var cache = [String: TransitionPresenter]()
  
  // MARK: Internal Interface
  public func retrievePresenter(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration = defaultTransitionDuration, interactiveGestureType: InteractiveGestureType? = nil) -> TransitionPresenter {
    // Get the cached presenter
    let presenter = cache[transitionAnimationType.stringValue]
    if let presenter = presenter {
      // Update the `transitionDuration` and `interactiveGestureType` every time to reuse the same presenter with the same type
      presenter.transitionDuration = transitionDuration
      presenter.interactiveGestureType = interactiveGestureType
      return presenter
    }
    
    // Create a new if cache doesn't exist
    let newPresenter = TransitionPresenter(transitionAnimationType: transitionAnimationType, transitionDuration: transitionDuration, interactiveGestureType: interactiveGestureType)
    cache[transitionAnimationType.stringValue] = newPresenter
    return newPresenter
  }
}
