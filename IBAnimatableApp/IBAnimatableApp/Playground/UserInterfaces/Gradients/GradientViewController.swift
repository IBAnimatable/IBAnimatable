//
//  Created by jason akakpo on 27/07/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class GradientViewController: UIViewController, GradientModePresenter {

  @IBOutlet fileprivate weak var gView: AnimatableView!

  let gradientValues = ParamType(fromEnum: GradientType.self)
  let startPointValues = ParamType.enumeration(values: ["top", "topLeft", "topRight", "left", "right", "bottom", "bottomRight", "bottomLeft"])
  let colorValues = ParamType(fromEnum: ColorType.self)
  var usePredefinedGradient = true
  var gradientMode: GradientMode = .linear
  lazy var componentValues: [ParamType] = {
    self.usePredefinedGradient ? [self.gradientValues, self.startPointValues] : [self.colorValues, self.colorValues, self.startPointValues]
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    gView.gradientMode = gradientMode
    if usePredefinedGradient {
      gView.predefinedGradient = GradientType(rawValue: gradientValues.value(at: 0))
      gView.startPoint = GradientStartPoint(string: startPointValues.value(at: 0))
    } else {
      gView.startColor = ColorType(rawValue: self.colorValues.value(at: 0))?.color
      gView.endColor = ColorType(rawValue: self.colorValues.value(at: 0))?.color
    }
    let navigationBar = self.navigationController?.navigationBar as? DesignableNavigationBar
    navigationBar?.copyGradient(from: gView)
    navigationBar?.configureGradient()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    let navigationBar = self.navigationController?.navigationBar as? DesignableNavigationBar
    navigationBar?.resetGradient()
    navigationBar?.setBackgroundImage(nil, for: .default)
  }

}

extension GradientViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
    if usePredefinedGradient {
      gView.predefinedGradient = GradientType(rawValue: gradientValues.value(at: pickerView.selectedRow(inComponent: 0)))
      gView.startPoint = GradientStartPoint(string: startPointValues.value(at: pickerView.selectedRow(inComponent: 1)))
    } else {
      gView.startColor = ColorType(rawValue: self.colorValues.value(at: pickerView.selectedRow(inComponent: 0)))?.color
      gView.endColor = ColorType(rawValue: self.colorValues.value(at: pickerView.selectedRow(inComponent: 1)))?.color
      gView.startPoint = GradientStartPoint(string: startPointValues.value(at: pickerView.selectedRow(inComponent: 2)))
    }
    gView.configureGradient()

    let navigationBar = self.navigationController?.navigationBar as? DesignableNavigationBar
    navigationBar?.copyGradient(from: gView)
    navigationBar?.configureGradient()
  }
}

fileprivate extension GradientDesignable {

  func copyGradient(from designable: GradientDesignable) {
    predefinedGradient = designable.predefinedGradient
    startColor = designable.startColor
    endColor = designable.endColor
    startPoint = designable.startPoint
  }

  func resetGradient(defaultStartPoint: GradientStartPoint = .top) {
    predefinedGradient = nil
    startColor = nil
    endColor = nil
    startPoint = defaultStartPoint
  }

}
