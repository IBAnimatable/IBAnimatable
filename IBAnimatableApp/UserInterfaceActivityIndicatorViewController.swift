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

  private var activityIndicatorsType: [String] {
    var types = [String]()
    iterateEnum(ActivityIndicatorType).forEach {
      types.append($0.rawValue)
    }
    return types
  }

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    if let animatableView = view as? AnimatableView {
      animatableView.predefinedGradient = String(generateRandomGradient())
    }
  }

}

extension UserInterfaceActivityIndicatorViewController {

  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return activityIndicatorsType.count
  }

  func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let title = activityIndicatorsType[row]
    return NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
  }

  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    activityIndicatorView.stopAnimating()
    activityIndicatorView.animationType = activityIndicatorsType[row]
    activityIndicatorView.startAnimating()
  }

}
