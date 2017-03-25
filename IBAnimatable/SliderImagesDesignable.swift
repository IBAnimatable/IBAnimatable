//
//  Created by phimage on 25/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import Foundation

import UIKit

/// Protocol for designing slider image
public protocol SliderImagesDesignable {

  /**
   * The thumb image when slider state is `normal`
   */
  var thumbImage: UIImage? { get set }

  /**
   * The thumb image when slider state is `highlighted`
   */
  var thumbHighlightedImage: UIImage? { get set }

  /**
   * The minimum track image when slider state is `normal`
   */
  var minimumTrackImage: UIImage? { get set }

  /**
   * The minimum track image when slider state is `highlighted`
   */
  var minimumTrackHighlightedImage: UIImage? { get set }

  /**
   * The maximum track image when slider state is `normal`
   */
  var maximumTrackImage: UIImage? { get set }

  /**
   * The maximum track image when slider state is `highlighted`
   */
  var maximumTrackHighlightedImage: UIImage? { get set }

}

extension SliderImagesDesignable where Self: UISlider {

  func configureThumbImage() {
    self.setThumbImage(thumbImage, for: .normal)
    if let highlighted = thumbHighlightedImage {
      self.setThumbImage(highlighted, for: .highlighted)
    } else {
      self.setThumbImage(thumbImage, for: .highlighted)
    }
  }

  func configureMinimumTrackImage() {
    self.setMinimumTrackImage(minimumTrackImage, for: .normal)
    if let highlighted = minimumTrackHighlightedImage {
      self.setMinimumTrackImage(highlighted, for: .highlighted)
    } else {
      self.setMinimumTrackImage(minimumTrackImage, for: .highlighted)
    }
  }

  func configureMaximumTrackImage() {
    self.setMaximumTrackImage(maximumTrackImage, for: .normal)
    if let highlighted = maximumTrackHighlightedImage {
      self.setMaximumTrackImage(highlighted, for: .highlighted)
    } else {
      self.setMaximumTrackImage(maximumTrackImage, for: .highlighted)
    }
  }

}
