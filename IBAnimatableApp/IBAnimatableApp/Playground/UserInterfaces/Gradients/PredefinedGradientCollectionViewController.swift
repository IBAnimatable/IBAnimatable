//
//  PredefinedGradientCollectionViewController.swift
//  IBAnimatableApp
//
//  Created by phimage on 05/05/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class PredefinedGradientCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  // MARK: Properties
  fileprivate var gradientTypes: [GradientType] {
    var types = [GradientType]()
    iterateEnum(GradientType.self).forEach {
      types.append($0)
    }
    return types
  }
  // MARK: UICollectionViewController
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return gradientTypes.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    if let cell = cell as? PredefinedGradientCollectionViewCell {
      let type = gradientTypes[indexPath.row]
      cell.nameLabel.text = type.rawValue
      cell.predefinedGradient = type
    }
    return cell
  }
  // MARK: UICollectionViewDelegateFlowLayout
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.size.width, height: 128)
  }

}

@IBDesignable
final class PredefinedGradientCollectionViewCell: AnimatableCollectionViewCell {

  // swiftlint:disable:next private_outlet
  @IBOutlet weak var nameLabel: UILabel!
}
