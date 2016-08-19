//
//  BlurEffectViewController.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 27/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class BlurEffectViewController: UIViewController {
  
  @IBOutlet weak var imageView: AnimatableImageView!
 
  let opacityValues = ParamType.number(min: 0.0, max: 1.0, interval: 0.1, ascending: false, unit: "")
  lazy var values: [String] = {
    var values = ["none", "extraLight", "light", "dark"]
    if #available(iOS 10.0, *) {
      values.append(contentsOf: ["prominent", "regular"])
    }
    return values
  }()
  
}

extension BlurEffectViewController : UIPickerViewDelegate, UIPickerViewDataSource {
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 2 {
      return opacityValues.count()
    }
    return values.count
  }
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    if component == 2 {
      return (opacityValues.titleAt(index: row) ).colorize(color: .white)
    }
      return values[safe: row]?.colorize(color: .white)
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    imageView.blurEffectStyle = UIBlurEffectStyle(string:values[pickerView.selectedRow(inComponent: 0)])
    imageView.vibrancyEffectStyle = UIBlurEffectStyle(string:values[pickerView.selectedRow(inComponent: 1)])
    imageView.blurOpacity = CGFloat(Double(opacityValues.valueAt(index: pickerView.selectedRow(inComponent: 2)))!)
  }

  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    let totalWidth =  self.view.frame.size.width
    if component == 2 {
      return 0.2 * totalWidth
    } else {
      return 0.4 * totalWidth
    }
  }
}
