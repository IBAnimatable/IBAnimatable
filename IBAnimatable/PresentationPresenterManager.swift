//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

public class PresentationPresenterManager {
  // MARK: - Singleton

  public static let shared = PresentationPresenterManager()

  private init() {}

  // MARK: - Private
  private var cache = [PresentationPresenterChacheKey: PresentationPresenter]()

  // MARK: Internal Interface
  public func retrievePresenter(presentationAnimationType: PresentationAnimationType, transitionDuration: Duration = defaultPresentationDuration, interactiveGestureType: InteractiveGestureType? = nil) -> PresentationPresenter {
    let key = PresentationPresenterChacheKey(presentationAnimationType: presentationAnimationType)
    let presenter = cache[key]
    if let presenter = presenter {
      presenter.transitionDuration = transitionDuration
      return presenter
    }

    let newPresenter = PresentationPresenter(presentationAnimationType: presentationAnimationType, transitionDuration: transitionDuration)
    cache[key] = newPresenter
    return newPresenter
  }
}
