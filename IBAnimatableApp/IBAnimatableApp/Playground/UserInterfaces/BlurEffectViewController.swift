//
//  Created by jason akakpo on 27/07/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class BlurEffectViewController: UIViewController {

  @IBOutlet fileprivate var blurEffectView: AnimatableView!

  let opacityValues = ParamType.number(min: 0.0, max: 1.0, interval: 0.1, ascending: false, unit: "")
  lazy var values: [String] = {
    var values = ["none", "extraLight", "light", "dark"]
    if #available(iOS 10.0, *) {
      values.append(contentsOf: ["prominent", "regular"])
    }
    return values
  }()
}

extension BlurEffectViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 2 {
      return opacityValues.count()
    }

    // When component == 0 || component == 1, display blur effects
    return values.count
  }
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }

  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    if component == 2 {
      return (opacityValues.title(at: row)).colorize(.white)
    }
      return values[safe: row]?.colorize(.white)
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    blurEffectView.blurEffectStyle = UIBlurEffect.Style(string: values[pickerView.selectedRow(inComponent: 0)])
    blurEffectView.vibrancyEffectStyle = UIBlurEffect.Style(string: values[pickerView.selectedRow(inComponent: 1)])
    blurEffectView.blurOpacity = CGFloat(Double(opacityValues.value(at: pickerView.selectedRow(inComponent: 2)))!)
  }

  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    let totalWidth = view.frame.size.width
    if component == 2 {
      return 0.2 * totalWidth
    } else {
      return 0.4 * totalWidth
    }
  }
}
