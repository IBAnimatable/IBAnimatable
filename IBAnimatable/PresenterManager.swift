//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 Presenter Manager: Used to cache the Presenters for Present and Dismiss transitions
 */
class PresenterManager {
  // MARK: - Singleton Constructor
  private init() {}
  private struct Shared {
    static let instance = PresenterManager()
  }
  internal static func sharedManager() -> PresenterManager {
    return Shared.instance
  }
  
  // MARK: - Private
  private var cache = [String: Presenter]()
  
  // MARK: Inertnal Interface
  func retrievePresenter(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration = defaultTransitionDuration, interactiveGestureType: InteractiveGestureType? = nil) -> Presenter {
    // Get the cached presenter
    let presenter = cache[transitionAnimationType.stringValue]
    if let presenter = presenter {
      // Update the `transitionDuration` and `interactiveGestureType` every time to reuse the same presenter with the same type
      presenter.transitionDuration = transitionDuration
      presenter.interactiveGestureType = interactiveGestureType
      return presenter
    }
    
    // Create a new if cache doesn't exist
    let newPresenter = Presenter(transitionAnimationType: transitionAnimationType, transitionDuration: transitionDuration, interactiveGestureType: interactiveGestureType)
    cache[transitionAnimationType.stringValue] = newPresenter
    return newPresenter
  }
}
