//
//  BlurEffectViewController.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 27/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class GradientViewController: UIViewController {
  
  @IBOutlet weak var gView: AnimatableView!
  
  let gradientValues = ParamType.init(fromEnum: GradientType.self)
  let startPointValues = ParamType.init(fromEnum: GradientStartPoint.self)
  let colorValues = ParamType.init(fromEnum: ColorType.self)
  var usePredefinedGradient = true
  lazy var componentValues: [ParamType] = {
    return self.usePredefinedGradient ? [self.gradientValues, self.startPointValues] : [self.colorValues, self.colorValues, self.startPointValues]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if usePredefinedGradient {
    gView.predefinedGradient = GradientType(string: gradientValues.valueAt(index: 0))
    gView.startPoint = GradientStartPoint(string: startPointValues.valueAt(index: 0)) ?? .top
    } else {
      gView.startColor = ColorType(string: self.colorValues.valueAt(index: 0))?.color
      gView.endColor = ColorType(string: self.colorValues.valueAt(index: 0))?.color
    }
  }
}

extension GradientViewController : UIPickerViewDelegate, UIPickerViewDataSource {
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return componentValues[component].count()
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return componentValues.count
  }
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = UILabel()
    label.textColor = .white
    label.textAlignment = .center
    label.minimumScaleFactor = 0.5
    label.text = componentValues[component].titleAt(index: row)
    return label
  }
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
      return componentValues[component].titleAt(index: row).colorize(color: .white)
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if usePredefinedGradient {
      gView.predefinedGradient = GradientType(string: gradientValues.valueAt(index: pickerView.selectedRow(inComponent: 0)))
      gView.startPoint = GradientStartPoint(string: startPointValues.valueAt(index: pickerView.selectedRow(inComponent: 1))) ?? .top
    } else {
      gView.startColor = ColorType(string: self.colorValues.valueAt(index: pickerView.selectedRow(inComponent: 0)))?.color
      gView.endColor = ColorType(string: self.colorValues.valueAt(index: pickerView.selectedRow(inComponent: 1)))?.color
    }
    gView.configGradient()
  }
}
