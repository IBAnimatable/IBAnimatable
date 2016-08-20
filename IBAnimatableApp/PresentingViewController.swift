//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class PresentingViewController: AnimatableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

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

  private let animations = ["None", "Flip", "CrossDissolve", "Cover(Left)", "Cover(Right)", "Cover(Top)", "Cover(Bottom)", "Zoom", "DropDown"]
  private let positions = ["Center", "TopCenter", "BottomCenter", "LeftCenter", "RightCenter"]
  private let sizes = ["Half", "Full"]
  private let keyboardTranslations = ["None", "MoveUp", "AboveKeyboard"]
  private let blurEffectStyles = ["None", "ExtraLight", "Light", "Dark"]
  private let colors = [UIColor.blackColor(), UIColor.redColor(), UIColor.orangeColor(), UIColor.brownColor(), UIColor.yellowColor(), UIColor.lightGrayColor(), UIColor.greenColor(), UIColor.cyanColor(), UIColor.blueColor(), UIColor.purpleColor(), UIColor.purpleColor().colorWithAlphaComponent(0.5), UIColor.darkGrayColor(), UIColor.magentaColor(), UIColor.whiteColor()]

  private var selectedButton: UIButton?

  private var selectedAnimationType: String?
  private var selectedDismissalAnimationType: String?
  private var selectedModalPosition: String?
  private var selectedModalWidth: String = "Half"
  private var selectedModalHeight: String = "Half"
  private var selectedKeyboardTranslation: String?
  private var selectedBlurEffectStyle: String?

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  private func setupModal(presentedViewController: AnimatableModalViewController) {
    presentedViewController.presentationAnimationType = selectedAnimationType
    presentedViewController.dismissalAnimationType = selectedDismissalAnimationType
    presentedViewController.modalPosition = selectedModalPosition ?? "Center"
    presentedViewController.modalWidth = selectedModalWidth ?? "Half"
    presentedViewController.modalHeight = selectedModalHeight ?? "Half"
    presentedViewController.backgroundColor = colors[Int(sliderBackgroundColor.value)]
    presentedViewController.opacity = CGFloat(sliderOpacity.value)
    presentedViewController.dismissOnTap = switchDismissOnTap.on
    presentedViewController.keyboardTranslation = selectedKeyboardTranslation
    presentedViewController.cornerRadius = CGFloat(sliderCornerRadius.value)
    presentedViewController.blurEffectStyle = selectedBlurEffectStyle
    presentedViewController.blurOpacity = CGFloat(sliderBlurOpacity.value)
    presentedViewController.shadowColor = colors[Int(sliderShadowColor.value)]
    presentedViewController.shadowOpacity = CGFloat(sliderShadowOpacity.value)
    presentedViewController.shadowRadius = CGFloat(sliderShadowRadius.value)
    presentedViewController.shadowOffset = CGPoint(x: CGFloat(sliderShadowOffsetX.value), y: CGFloat(sliderShadowOffsetY.value))

    setDismissalAnimationTypeIfNeeded(presentedViewController)
  }

  private func setDismissalAnimationTypeIfNeeded(viewController: AnimatableModalViewController) {
    guard selectedDismissalAnimationType == nil else {
      return
    }
    
    // FIXME: Dirty hack to make `Flip` and `CrossDissolve` work properly for dismissal transition.
    // If we don't apply this hack, both the dismissal transitions of `Flip` and `CrossDissolve` will slide down the modal not flip or crossDissolve(fade).
    if viewController.presentationAnimationType == "Flip" {
      viewController.dismissalAnimationType = "Flip"
    } else if viewController.presentationAnimationType == "CrossDissolve" {
      viewController.dismissalAnimationType = "CrossDissolve"
    }
  }
}

// MARK: - IBAction

extension PresentingViewController {

  @IBAction func presentProgramatically() {
    if let presentedViewController = UIStoryboard(name: "Presentations", bundle: nil).instantiateViewControllerWithIdentifier("PresentationPresentedViewController") as? AnimatableModalViewController {
      setupModal(presentedViewController)
      presentViewController(presentedViewController, animated: true, completion: nil)
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

  @IBAction func backgroundColorValueChanged(sender: UISlider) {
    //    labelShadowOpacity.text = "Shadow opacity (\(sender.value))"
  }

  @IBAction func cornerRadiusValueChanged(sender: UISlider) {
    labelCornerRadius.text = "Corner radius (\(sender.value))"
  }

  @IBAction func opacityValueChanged(sender: UISlider) {
    labelOpacity.text = "Opacity (\(sender.value))"
  }

  @IBAction func blurOpacityValueChanged(sender: UISlider) {
    labelBlurOpacity.text = "Blur opacity (\(sender.value))"
  }

  @IBAction func shadowColorValueChanged(sender: UISlider) {
//    labelShadowOpacity.text = "Shadow opacity (\(sender.value))"
  }

  @IBAction func shadowOpacityValueChanged(sender: UISlider) {
    labelShadowOpacity.text = "Shadow opacity (\(sender.value))"
  }

  @IBAction func shadowRadiusValueChanged(sender: UISlider) {
    labelShadowRadius.text = "Shadow radius (\(sender.value))"
  }

  @IBAction func shadowOffsetXValueChanged(sender: UISlider) {
    labelShadowOffsetX.text = "Shadow offset X (\(sender.value))"
  }

  @IBAction func shadowOffsetYValueChanged(sender: UISlider) {
    labelShadowOffsetY.text = "Shadow offset Y (\(sender.value))"
  }
}

// MARK: - Picker

extension PresentingViewController {

  func showPicker() {
    pickerView.reloadAllComponents()
    resetSelectedItemPicker()
    dimmingPickerView.fadeIn()
    containerPickerView.slideInUp()
    dimmingPickerView.hidden = false
  }

  @IBAction func hidePicker() {
    dimmingPickerView.fadeOut({
      self.dimmingPickerView.hidden = true
    })
    containerPickerView.slideOutDown()
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
      row = animations.indexOf(selectedAnimationType ?? "")      
    } else if selectedButton == btnDismissalAnimationType {
      row = animations.indexOf(selectedDismissalAnimationType ?? "")
    } else if selectedButton == btnModalPosition {
      row = positions.indexOf(selectedModalPosition ?? "")
    } else if selectedButton == btnModalSize {
      pickerView.selectRow(sizes.indexOf(selectedModalWidth ?? "") ?? 0, inComponent: 0, animated: false)
      pickerView.selectRow(sizes.indexOf(selectedModalHeight ?? "") ?? 0, inComponent: 1, animated: false)
      return
    } else if selectedButton == btnKeyboardTranslation {
      row = keyboardTranslations.indexOf(selectedKeyboardTranslation ?? "")
    } else if selectedButton == btnBlurEffectStyle {
      row = blurEffectStyles.indexOf(selectedBlurEffectStyle ?? "")
    }
    pickerView.selectRow(row ?? 0, inComponent: 0, animated: false)
  }

  // MARK: UIPickerDelegate / DataSource

  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return componentsForSelectedButton().count
  }

  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return componentsForSelectedButton()[component].count
  }

  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return componentsForSelectedButton()[component][row]
  }

  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let title = componentsForSelectedButton()[component][row]
    if selectedButton == btnAnimationType {
      btnAnimationType.setTitle("Animation type (\(title))", forState: .Normal)
      selectedAnimationType = title
    } else if selectedButton == btnDismissalAnimationType {
      btnDismissalAnimationType.setTitle("Dismissal animation type (\(title))", forState: .Normal)
      selectedDismissalAnimationType = title
    } else if selectedButton == btnModalPosition {
      btnModalPosition.setTitle("Modal Position (\(title))", forState: .Normal)
      selectedModalPosition = title
    } else if selectedButton == btnModalSize && component == 0 {
      btnModalSize.setTitle("Modal size (\(title) - \(selectedModalHeight))", forState: .Normal)
      selectedModalWidth = title
    } else if selectedButton == btnModalSize && component == 1 {
      btnModalSize.setTitle("Modal size (\(selectedModalWidth) - \(title))", forState: .Normal)
      selectedModalHeight = title
    } else if selectedButton == btnKeyboardTranslation {
      btnKeyboardTranslation.setTitle("Keyboard translation (\(title))", forState: .Normal)
      selectedKeyboardTranslation = title
    } else if selectedButton == btnBlurEffectStyle {
      btnBlurEffectStyle.setTitle("Blur effect style (\(title))", forState: .Normal)
      selectedBlurEffectStyle = title
    }
  }
  
}
