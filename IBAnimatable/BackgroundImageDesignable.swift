//
//  Created by phimage on 25/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import Foundation

import UIKit

/// Protocol for designing background image
public protocol BackgroundImageDesignable {

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

fileprivate typealias BackgroundImageView = AnimatableImageView

public extension BackgroundImageDesignable where Self: BackgroundDesignable {
  public func configureBackgroundImage() {
    if let image = backgroundImage {
      if let imageView = self.backgroundView as? AnimatableImageView {
        imageView.image = image
      } else {
        backgroundView = BackgroundImageView(image: image)
      }
    } else {
      if self.backgroundView is BackgroundImageView {
        backgroundView = nil
      }
    }
  }

  public var backgroundImageView: UIImageView? {
    get {
      return self.backgroundView as? UIImageView
    }
    set {
      self.backgroundView = newValue
    }
  }
}
