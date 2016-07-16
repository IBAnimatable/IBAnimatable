//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 Presenter Manager: Used to cache the Presenters for Present and Dismiss transitions
 */
public class PresenterManager {
  // MARK: - Singleton Constructor
  private init() {}
  private struct Shared {
    static let instance = PresenterManager()
  }
  
  public static func sharedManager() -> PresenterManager {
    return Shared.instance
  }
  
  // MARK: - Private
  private var cache = [String: Presenter]()
  
  // MARK: Internal Interface
  public func retrievePresenter(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration = defaultTransitionDuration, interactiveGestureType: InteractiveGestureType? = nil, presenterSetup: PresentedSetup? = nil) -> Presenter {
    // Get the cached presenter
    let presenter = cache[transitionAnimationType.stringValue]
    if let presenter = presenter {
      // Update the `transitionDuration` and `interactiveGestureType` every time to reuse the same presenter with the same type
      presenter.transitionDuration = transitionDuration
      presenter.interactiveGestureType = interactiveGestureType
      presenter.presenterSetup = presenterSetup
      return presenter
    }
    
    // Create a new if cache doesn't exist
    let newPresenter = Presenter(transitionAnimationType: transitionAnimationType, transitionDuration: transitionDuration, interactiveGestureType: interactiveGestureType, presenterSetup: presenterSetup)
    cache[transitionAnimationType.stringValue] = newPresenter
    return newPresenter
  }
}
