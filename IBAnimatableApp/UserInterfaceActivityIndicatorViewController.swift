//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

class UserInterfaceActivityIndicatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  // MARK: Properties IB

  @IBOutlet weak var activityIndicatorView: AnimatableActivityIndicatorView!

  // MARK: Properties

  fileprivate var activityIndicatorsType: [ActivityIndicatorType] {
    var types = [ActivityIndicatorType]()
    iterateEnum(ActivityIndicatorType.self).forEach {
      types.append($0)
    }
    return types
  }

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    if let animatableView = view as? AnimatableView {
      animatableView.predefinedGradient = makeRandomGradient()
    }
  }

}

extension UserInterfaceActivityIndicatorViewController {

  @objc(numberOfComponentsInPickerView:)
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return activityIndicatorsType.count
  }

  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let title = activityIndicatorsType[row]
    return NSAttributedString(string: title.rawValue, attributes: [NSForegroundColorAttributeName: UIColor.white])
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    activityIndicatorView.stopAnimating()
    activityIndicatorView.animationType = activityIndicatorsType[row]
    activityIndicatorView.startAnimating()
  }

}
