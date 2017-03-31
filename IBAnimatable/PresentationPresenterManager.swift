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
  private var cache = [PresentationAnimationType: PresentationPresenter]()

  // MARK: Internal Interface
  public func retrievePresenter(presentationAnimationType: PresentationAnimationType,
                                transitionDuration: Duration = defaultPresentationDuration,
                                interactiveGestureType: InteractiveGestureType? = nil) -> PresentationPresenter {
    let presenter = cache[presentationAnimationType]
    if let presenter = presenter {
      presenter.transitionDuration = transitionDuration
      return presenter
    }

    let newPresenter = PresentationPresenter(presentationAnimationType: presentationAnimationType, transitionDuration: transitionDuration)
    cache[presentationAnimationType] = newPresenter
    return newPresenter
  }
}
