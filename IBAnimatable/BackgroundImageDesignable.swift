//
//  Created by phimage on 25/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

/// Protocol for designing background image
public protocol BackgroundImageDesignable: class {

  /**
   * The background image
   */
  var backgroundImage: UIImage? { get set }

}

/// Protocol for designing background
public protocol BackgroundDesignable: class {

  /**
   * The background view
   */
  var backgroundView: UIView? { get set }

}

extension UITableViewCell: BackgroundDesignable {}
extension UITableViewHeaderFooterView: BackgroundDesignable {}
extension UITableView: BackgroundDesignable {}
extension UICollectionViewCell: BackgroundDesignable {}
extension UICollectionView: BackgroundDesignable {}

public extension BackgroundImageDesignable where Self: BackgroundDesignable {

  public func configureBackgroundImage() {
    if let image = backgroundImage {
      if let imageView = backgroundView as? UIImageView {
        imageView.image = image
      } else {
        backgroundView = PrivateAnimatableImageView(image: image)
      }
    } else {
      if backgroundView is PrivateAnimatableImageView {
        backgroundView = nil
      }
    }
  }

  public var backgroundImageView: UIImageView? {
    get {
      return backgroundView as? UIImageView
    }
    set {
      backgroundView = newValue
    }
  }

}

/// Private class of image view used in `BackgroundImageDesignable` only
private class PrivateAnimatableImageView: AnimatableImageView {

}
