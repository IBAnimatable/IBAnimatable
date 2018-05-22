//
//  GradientCustomStartPointViewController.swift
//  IBAnimatable
//
//  Created by Tom Baranes on 22/12/2016.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class GradientCustomStartPointViewController: UIViewController, GradientModePresenter {

  @IBOutlet fileprivate weak var gView: AnimatableView!

  var gradientMode: GradientMode = .linear
  let gradientValues = ParamType(fromEnum: GradientType.self)
  let coordPointValues = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")
  lazy var componentValues: [ParamType] = [self.gradientValues,
                                           self.coordPointValues,
                                           self.coordPointValues,
                                           self.coordPointValues,
                                           self.coordPointValues]

  override func viewDidLoad() {
    super.viewDidLoad()
    gView.gradientMode = gradientMode
    gView.predefinedGradient = GradientType(rawValue: gradientValues.value(at: 0))
  }
}

extension GradientCustomStartPointViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
    label.text = componentValues[component].title(at: row)
    return label
  }
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    return componentValues[component].title(at: row).colorize(.white)
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let startX = pickerView.selectedRow(inComponent: 1)
    let startY = pickerView.selectedRow(inComponent: 2)
    let endX = pickerView.selectedRow(inComponent: 3)
    let endY = pickerView.selectedRow(inComponent: 4)
    let startPoint = CGPoint(x: Double(coordPointValues.value(at: startX)) ?? 0, y: Double(coordPointValues.value(at: startY)) ?? 0)
    let endPoint = CGPoint(x: Double(coordPointValues.value(at: endX)) ?? 0, y: Double(coordPointValues.value(at: endY)) ?? 0)

    gView.startPoint = .custom(start: startPoint, end: endPoint)
    gView.predefinedGradient = GradientType(rawValue: gradientValues.value(at: pickerView.selectedRow(inComponent: 0)))
    gView.configureGradient()
  }
}
