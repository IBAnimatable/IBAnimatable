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
  private var cache = [TransitionAnimationType: Presenter]()
  
  // MARK: Inertnal Interface
  func retrievePresenter(transitionAnimationType: TransitionAnimationType) -> Presenter {
    // Get the cached presenter
    let presenter = cache[transitionAnimationType]
    if let presenter = presenter {
      return presenter
    }
    
    // Create a new if cache doesn't exist
    let newPresenter = Presenter(transitionAnimationType: transitionAnimationType)
    cache[transitionAnimationType] = newPresenter
    return newPresenter
  }
}
