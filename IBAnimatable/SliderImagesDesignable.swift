//
//  Created by phimage on 25/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

/// Protocol for designing slider image
public protocol SliderImagesDesignable: class {

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

public extension SliderImagesDesignable where Self: UISlider {

  func configureThumbImage() {
    setThumbImage(thumbImage, for: .normal)
    if let highlighted = thumbHighlightedImage {
      setThumbImage(highlighted, for: .highlighted)
    } else {
      setThumbImage(thumbImage, for: .highlighted)
    }
  }

  func configureMinimumTrackImage() {
    setMinimumTrackImage(minimumTrackImage, for: .normal)
    if let highlighted = minimumTrackHighlightedImage {
      setMinimumTrackImage(highlighted, for: .highlighted)
    } else {
      setMinimumTrackImage(minimumTrackImage, for: .highlighted)
    }
  }

  func configureMaximumTrackImage() {
    setMaximumTrackImage(maximumTrackImage, for: .normal)
    if let highlighted = maximumTrackHighlightedImage {
      setMaximumTrackImage(highlighted, for: .highlighted)
    } else {
      setMaximumTrackImage(maximumTrackImage, for: .highlighted)
    }
  }

}
