//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

final class PresentingViewController: AnimatableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

  // MARK: Properties IB

  @IBOutlet weak var btnAnimationType: AnimatableButton!
  @IBOutlet weak var btnDismissalAnimationType: AnimatableButton!
  @IBOutlet weak var btnModalPosition: AnimatableButton!
  @IBOutlet weak var btnModalSize: AnimatableButton!
  @IBOutlet weak var btnKeyboardTranslation: AnimatableButton!
  @IBOutlet weak var btnBlurEffectStyle: AnimatableButton!

  @IBOutlet weak var labelCornerRadius: UILabel!
  @IBOutlet weak var labelOpacity: UILabel!
  @IBOutlet weak var labelBlurOpacity: UILabel!
  @IBOutlet weak var labelShadowOpacity: UILabel!
  @IBOutlet weak var labelShadowRadius: UILabel!
  @IBOutlet weak var labelShadowOffsetX: UILabel!
  @IBOutlet weak var labelShadowOffsetY: UILabel!

  @IBOutlet weak var dimmingPickerView: AnimatableView!
  @IBOutlet weak var containerPickerView: AnimatableView!
  @IBOutlet weak var pickerView: UIPickerView!

  @IBOutlet var sliderBackgroundColor: UISlider!
  @IBOutlet var sliderCornerRadius: UISlider!
  @IBOutlet var switchDismissOnTap: UISwitch!
  @IBOutlet var sliderOpacity: UISlider!
  @IBOutlet var sliderBlurOpacity: UISlider!
  @IBOutlet var sliderShadowColor: UISlider!
  @IBOutlet var sliderShadowOpacity: UISlider!
  @IBOutlet var sliderShadowRadius: UISlider!
  @IBOutlet var sliderShadowOffsetX: UISlider!
  @IBOutlet var sliderShadowOffsetY: UISlider!

  // MARK: Properties

  fileprivate let animations = ["None", "Flip", "CrossDissolve", "Cover(Left)", "Cover(Right)", "Cover(Top)", "Cover(Bottom)", "Zoom", "DropDown"]
  fileprivate let positions = ["Center", "TopCenter", "BottomCenter", "LeftCenter", "RightCenter"]
  fileprivate let sizes = ["Half", "Full", "custom(100)"]
  fileprivate let keyboardTranslations = ["None", "MoveUp", "AboveKeyboard", "stickOrMoveUp"]
  fileprivate let blurEffectStyles = ["None", "ExtraLight", "Light", "Dark"]
  fileprivate let colors = [.black, .red, .orange, .brown, .yellow, .lightGray, .green, .cyan, .blue, .purple,
                            UIColor.purple.withAlphaComponent(0.5), .darkGray, .magenta, .white]

  fileprivate var selectedButton: UIButton?

  fileprivate var selectedAnimationType: String?
  fileprivate var selectedDismissalAnimationType: String?
  fileprivate var selectedModalPosition: String?
  fileprivate var selectedModalWidth: String = "Half"
  fileprivate var selectedModalHeight: String = "Half"
  fileprivate var selectedKeyboardTranslation: String?
  fileprivate var selectedBlurEffectStyle: String?

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  fileprivate func setupModal(for presentedViewController: AnimatableModalViewController) {
    presentedViewController.presentationAnimationType = PresentationAnimationType(string: selectedAnimationType) ?? .cover(from: .bottom)
    presentedViewController.dismissalAnimationType = PresentationAnimationType(string: selectedDismissalAnimationType) ?? .cover(from: .bottom)
    presentedViewController.modalPosition = PresentationModalPosition(string: selectedModalPosition)
    presentedViewController.modalSize = (width: PresentationModalSize(string: selectedModalWidth)!,
                                         height: PresentationModalSize(string:selectedModalHeight)!)

    presentedViewController.backgroundColor = colors[Int(sliderBackgroundColor.value)]
    presentedViewController.opacity = CGFloat(sliderOpacity.value)
    presentedViewController.dismissOnTap = switchDismissOnTap.isOn
    presentedViewController.keyboardTranslation = ModalKeyboardTranslation(string: selectedKeyboardTranslation) ?? .none
    presentedViewController.cornerRadius = CGFloat(sliderCornerRadius.value)
    presentedViewController.blurEffectStyle = UIBlurEffectStyle(string: selectedBlurEffectStyle)
    presentedViewController.blurOpacity = CGFloat(sliderBlurOpacity.value)
    presentedViewController.shadowColor = colors[Int(sliderShadowColor.value)]
    presentedViewController.shadowOpacity = CGFloat(sliderShadowOpacity.value)
    presentedViewController.shadowRadius = CGFloat(sliderShadowRadius.value)
    presentedViewController.shadowOffset = CGPoint(x: CGFloat(sliderShadowOffsetX.value), y: CGFloat(sliderShadowOffsetY.value))

    setDismissalAnimationTypeIfNeeded(presentedViewController)
  }

  fileprivate func setDismissalAnimationTypeIfNeeded(_ viewController: AnimatableModalViewController) {
    guard selectedDismissalAnimationType == nil else {
      return
    }

    // FIXME: Dirty hack to make `Flip` and `CrossDissolve` work properly for dismissal transition.
    // If we don't apply this hack, both the dismissal transitions of `Flip` and `CrossDissolve` will slide down the modal not flip or crossDissolve(fade).
    if viewController.presentationAnimationType.stringValue == PresentationAnimationType.flip.stringValue {
      viewController.dismissalAnimationType = .flip
    } else if viewController.presentationAnimationType.stringValue == PresentationAnimationType.crossDissolve.stringValue {
      viewController.dismissalAnimationType = .crossDissolve
    }
  }
}

// MARK: - IBAction

extension PresentingViewController {

  @IBAction func presentProgramatically() {
    let storyboard = UIStoryboard(name: "Presentations", bundle: nil)
    let presentedVC = storyboard.instantiateViewController(withIdentifier: "PresentedViewController")
    if let presentedViewController = presentedVC as? AnimatableModalViewController {
      setupModal(for: presentedViewController)
      present(presentedViewController, animated: true, completion: nil)
    }
  }

  @IBAction func animationTypePressed() {
    selectedButton = btnAnimationType
    showPicker()
  }

  @IBAction func dismissalAnimationTypePressed() {
    selectedButton = btnDismissalAnimationType
    showPicker()
  }

  @IBAction func modalPositionPressed() {
    selectedButton = btnModalPosition
    showPicker()
  }

  @IBAction func modalSizePressed() {
    selectedButton = btnModalSize
    showPicker()
  }

  @IBAction func keyboardTranslationPressed() {
    selectedButton = btnKeyboardTranslation
    showPicker()
  }

  @IBAction func blurEffectStylePressed() {
    selectedButton = btnBlurEffectStyle
    showPicker()
  }

}

// MARK: - Slider value changed

extension PresentingViewController {

  @IBAction func backgroundColorValueChanged(_ sender: UISlider) {
    //    labelShadowOpacity.text = "Shadow opacity (\(sender.value))"
  }

  @IBAction func cornerRadiusValueChanged(_ sender: UISlider) {
    labelCornerRadius.text = "Corner radius (\(sender.value))"
  }

  @IBAction func opacityValueChanged(_ sender: UISlider) {
    labelOpacity.text = "Opacity (\(sender.value))"
  }

  @IBAction func blurOpacityValueChanged(_ sender: UISlider) {
    labelBlurOpacity.text = "Blur opacity (\(sender.value))"
  }

  @IBAction func shadowColorValueChanged(_ sender: UISlider) {
    //    labelShadowOpacity.text = "Shadow opacity (\(sender.value))"
  }

  @IBAction func shadowOpacityValueChanged(_ sender: UISlider) {
    labelShadowOpacity.text = "Shadow opacity (\(sender.value))"
  }

  @IBAction func shadowRadiusValueChanged(_ sender: UISlider) {
    labelShadowRadius.text = "Shadow radius (\(sender.value))"
  }

  @IBAction func shadowOffsetXValueChanged(_ sender: UISlider) {
    labelShadowOffsetX.text = "Shadow offset X (\(sender.value))"
  }

  @IBAction func shadowOffsetYValueChanged(_ sender: UISlider) {
    labelShadowOffsetY.text = "Shadow offset Y (\(sender.value))"
  }
}

// MARK: - Picker

extension PresentingViewController {

  func showPicker() {
    pickerView.reloadAllComponents()
    resetSelectedItemPicker()
    dimmingPickerView.animate(.fade(way: .in))
    containerPickerView.animate(.slide(way: .in, direction: .up))
    dimmingPickerView.isHidden = false
  }

  @IBAction func hidePicker() {
    dimmingPickerView.animate(.fade(way: .out)).completion {
      self.dimmingPickerView.isHidden = true
    }
    containerPickerView.animate(.slide(way: .out, direction: .down))
    selectedButton = nil
  }

  // MARK: Helpers

  func componentsForSelectedButton() -> [[String]] {
    if selectedButton == btnAnimationType || selectedButton == btnDismissalAnimationType {
      return [animations]
    } else if selectedButton == btnModalPosition {
      return [positions]
    } else if selectedButton == btnModalSize {
      return [sizes, sizes]
    } else if selectedButton == btnKeyboardTranslation {
      return [keyboardTranslations]
    }
    return [blurEffectStyles]
  }

  func resetSelectedItemPicker() {
    var row: Int?
    if selectedButton == btnAnimationType {
      row = animations.index(of: selectedAnimationType ?? "")
    } else if selectedButton == btnDismissalAnimationType {
      row = animations.index(of: selectedDismissalAnimationType ?? "")
    } else if selectedButton == btnModalPosition {
      row = positions.index(of: selectedModalPosition ?? "")
    } else if selectedButton == btnModalSize {
      pickerView.selectRow(sizes.index(of: selectedModalWidth) ?? 0, inComponent: 0, animated: false)
      pickerView.selectRow(sizes.index(of: selectedModalHeight) ?? 0, inComponent: 1, animated: false)
      return
    } else if selectedButton == btnKeyboardTranslation {
      row = keyboardTranslations.index(of: selectedKeyboardTranslation ?? "")
    } else if selectedButton == btnBlurEffectStyle {
      row = blurEffectStyles.index(of: selectedBlurEffectStyle ?? "")
    }
    pickerView.selectRow(row ?? 0, inComponent: 0, animated: false)
  }

  // MARK: UIPickerDelegate / DataSource

  @objc(numberOfComponentsInPickerView:)
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return componentsForSelectedButton().count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return componentsForSelectedButton()[component].count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return componentsForSelectedButton()[component][row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let title = componentsForSelectedButton()[component][row]
    if selectedButton == btnAnimationType {
      btnAnimationType.setTitle("Animation type (\(title))", for: .normal)
      selectedAnimationType = title
    } else if selectedButton == btnDismissalAnimationType {
      btnDismissalAnimationType.setTitle("Dismissal animation type (\(title))", for: .normal)
      selectedDismissalAnimationType = title
    } else if selectedButton == btnModalPosition {
      btnModalPosition.setTitle("Modal Position (\(title))", for: .normal)
      selectedModalPosition = title
    } else if selectedButton == btnModalSize && component == 0 {
      btnModalSize.setTitle("Modal size (\(title) - \(selectedModalHeight))", for: .normal)
      selectedModalWidth = title
    } else if selectedButton == btnModalSize && component == 1 {
      btnModalSize.setTitle("Modal size (\(selectedModalWidth) - \(title))", for: .normal)
      selectedModalHeight = title
    } else if selectedButton == btnKeyboardTranslation {
      btnKeyboardTranslation.setTitle("Keyboard translation (\(title))", for: .normal)
      selectedKeyboardTranslation = title
    } else if selectedButton == btnBlurEffectStyle {
      btnBlurEffectStyle.setTitle("Blur effect style (\(title))", for: .normal)
      selectedBlurEffectStyle = title
    }
  }

}
