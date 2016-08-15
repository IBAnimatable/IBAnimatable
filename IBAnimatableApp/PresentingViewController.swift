//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class PresentingViewController: AnimatableViewController {

  // MARK: Properties IB

  @IBOutlet weak var btnAnimationType: AnimatableButton!
  @IBOutlet weak var btnDismissalAnimationType: AnimatableButton!
  @IBOutlet weak var btnModalPosition: AnimatableButton!
  @IBOutlet weak var btnModalSize: AnimatableButton!
  @IBOutlet weak var btnKeyboardTranslation: AnimatableButton!
  @IBOutlet weak var btnBlurEffectStyle: AnimatableButton!
  @IBOutlet weak var btnBackgroundColor: AnimatableButton!
  @IBOutlet weak var btnShadowColor: AnimatableButton!

  @IBOutlet weak var labelCornerRadius: UILabel!
  @IBOutlet weak var labelOpacity: UILabel!
  @IBOutlet weak var labelBlurOpacity: UILabel!
  @IBOutlet weak var labelShadowOpacity: UILabel!
  @IBOutlet weak var labelShadowRadius: UILabel!
  @IBOutlet weak var labelShadowOffsetX: UILabel!
  @IBOutlet weak var labelShadowOffsetY: UILabel!


  @IBOutlet var sliderCornerRadius: UISlider!
  @IBOutlet var switchDismissOnTap: UISwitch!
  @IBOutlet var sliderOpacity: UISlider!
  @IBOutlet var sliderBlurOpacity: UISlider!
  @IBOutlet var sliderShadowOpacity: UISlider!
  @IBOutlet var sliderShadowRadius: UISlider!
  @IBOutlet var sliderShadowOffsetX: UISlider!
  @IBOutlet var sliderShadowOffsetY: UISlider!

  // MARK: Properties

  let animations = ["Flip", "CrossDissolve", "Cover(Left)", "Cover(Right)", "Cover(Top)", "Cover(Bottom)", "Zoom", "DropDown"]
  let positions = ["Center", "TopCenter", "BottomCenter", "LeftCenter", "RightCenter", "CustomCenter", "CustomOrigin"]
  let sizes = ["Half", "Full", "Custom"]
  let keyboardTranslation = ["MoveUp", "AboveKeyboard"]
  let blurEffectStyle = ["ExtraLight", "Light", "Dark"]

  var selectedAnimationType: String?
  var selectedDismissalAnimationType: String?
  var selectedModalPosition: String?
  var selectedModalWidth: String?
  var selectedModalHeight: String?
  var selectedKeyboardTranslation: String?
  var selectedBlurEffectStyle: String?
  var selectedBackgroundColor: UIColor?
  var selectedShadowColor: UIColor?


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
    presentedViewController.backgroundColor = selectedBackgroundColor ?? .blackColor()
    presentedViewController.dismissOnTap = switchDismissOnTap.on
    presentedViewController.keyboardTranslation = selectedKeyboardTranslation
    presentedViewController.cornerRadius = CGFloat(sliderCornerRadius.value)
    presentedViewController.blurOpacity = CGFloat(sliderBlurOpacity.value)
    presentedViewController.shadowColor = selectedShadowColor
    presentedViewController.shadowOpacity = CGFloat(sliderShadowOpacity.value)
    presentedViewController.shadowRadius = CGFloat(sliderShadowRadius.value)
    presentedViewController.shadowOffset = CGPoint(x: CGFloat(sliderShadowOffsetX.value), y: CGFloat(sliderShadowOffsetY.value))

    setDismissalAnimationTypeIfNeeded(presentedViewController)
  }

  private func setDismissalAnimationTypeIfNeeded(viewController: AnimatableModalViewController) {
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

  }

  @IBAction func dismissalAnimationTypePressed() {

  }

  @IBAction func modalPositionPressed() {

  }

  @IBAction func modalSizePressed() {

  }

  @IBAction func keyboardTranslationPressed() {

  }

  @IBAction func backgroundColorPressed() {

  }

  @IBAction func shadowColorPressed() {

  }

  @IBAction func blurEffectStylePressed() {

  }

}

// MARK: - Slider value changed

extension PresentingViewController {

  @IBAction func cornerRadiusValueChanged(sender: AnyObject) {
  }

  @IBAction func opacityValueChanged(sender: AnyObject) {
  }

  @IBAction func blurOpacityValueChanged(sender: AnyObject) {
  }

  @IBAction func shadowOpacityValueChanged(sender: AnyObject) {
  }

  @IBAction func shadowRadiusValueChanged(sender: AnyObject) {
  }

  @IBAction func shadowOffsetXValueChanged(sender: AnyObject) {
  }

  @IBAction func shadowOffsetYValueChanged(sender: AnyObject) {
  }
}
