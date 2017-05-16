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
    let highlightedImage = thumbHighlightedImage ?? thumbImage
    setThumbImage(thumbImage, for: .normal)
    setThumbImage(highlightedImage, for: .highlighted)
  }

  func configureMinimumTrackImage() {
    let highlightedImage = minimumTrackHighlightedImage ?? minimumTrackImage
    setMinimumTrackImage(minimumTrackImage, for: .normal)
    setMinimumTrackImage(highlightedImage, for: .highlighted)
  }

  func configureMaximumTrackImage() {
    let highlightedImage = maximumTrackHighlightedImage ?? maximumTrackImage
    setMaximumTrackImage(maximumTrackImage, for: .normal)
    setMaximumTrackImage(highlightedImage, for: .highlighted)
  }

}
