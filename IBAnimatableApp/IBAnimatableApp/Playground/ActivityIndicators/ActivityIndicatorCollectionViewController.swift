//
//  ActivityIndicatorCollectionViewController.swift
//  IBAnimatableApp
//
//  Created by phimage on 02/05/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class ActivityIndicatorCollectionViewController: UICollectionViewController {
  // MARK: Properties

  fileprivate var activityIndicatorsType: [ActivityIndicatorType] {
    var types = [ActivityIndicatorType]()
    iterateEnum(ActivityIndicatorType.self).forEach {
      types.append($0)
    }
    if types.count % 2 != 0, let index = types.firstIndex(of: .none) {
      types.remove(at: index)
    }
    return types
  }

  // MARK: UICollectionViewController
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return activityIndicatorsType.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    if let activityCell = cell as? ActivityIndicatorCollectionViewCell {
      activityCell.type = activityIndicatorsType[indexPath.row]
    }
    return cell
  }

}

@IBDesignable
final class ActivityIndicatorCollectionViewCell: AnimatableCollectionViewCell {

  // swiftlint:disable:next private_outlet
  @IBOutlet weak var activityIndicatorView: AnimatableActivityIndicatorView!
  // swiftlint:disable:next private_outlet
  @IBOutlet weak var nameLabel: UILabel!
  var type: ActivityIndicatorType = .none {
    didSet {
      activityIndicatorView.stopAnimating()
      activityIndicatorView.animationType = type
      activityIndicatorView.startAnimating()
      nameLabel.text = type.rawValue
    }
  }
}
