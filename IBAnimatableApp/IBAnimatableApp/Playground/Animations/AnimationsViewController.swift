//
//  Created by jason akakpo on 12/07/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

private let wayParam = ParamType(fromEnum: AnimationType.Way.self)
private let directionParam = ParamType(fromEnum: AnimationType.Direction.self)
private let fadeWayParams = ParamType(fromEnum: AnimationType.FadeWay.self)
private let axisParams = ParamType(fromEnum: AnimationType.Axis.self)
private let rotationDirectionParams = ParamType(fromEnum: AnimationType.RotationDirection.self)
private let positiveNumberParam = ParamType.number(min: 0, max: 50, interval: 2, ascending: true, unit: "")
private let numberParam = ParamType.number(min: -50, max: 200, interval: 10, ascending: true, unit: "")
private let repeatCountParam = ParamType.number(min: 1, max: 10, interval: 1, ascending: true, unit: "")
private let scaleParam = ParamType.number(min: 0, max: 2, interval: 0.1, ascending: true, unit: "")
private let animationParam = ParamType.enumeration(values: ["slide", "shake", "pop", "pop[2]"])
private let runParam = ParamType(fromEnum: AnimationType.Run.self)

final class AnimationsViewController: UIViewController {

  @IBOutlet fileprivate weak var animatableView: AnimatableView!
  @IBOutlet fileprivate weak var pickerView: UIPickerView!
  @IBOutlet fileprivate weak var timingFunctionButton: UIBarButtonItem!

  // prebuit common params
  let entries: [PickerEntry] = [
    PickerEntry(params: [wayParam, directionParam], name: "slide"),
    PickerEntry(params: [wayParam, directionParam], name: "squeeze"),
    PickerEntry(params: [fadeWayParams], name: "fade"),
    PickerEntry(params: [wayParam, directionParam], name: "slideFade"),
    PickerEntry(params: [wayParam, directionParam], name: "squeezeFade"),
    PickerEntry(params: [wayParam], name: "zoom"),
    PickerEntry(params: [wayParam], name: "zoomInvert"),
    PickerEntry(params: [axisParams], name: "flip"),
    PickerEntry(params: [repeatCountParam], name: "shake"),
    PickerEntry(params: [repeatCountParam], name: "pop"),
    PickerEntry(params: [repeatCountParam], name: "squash"),
    PickerEntry(params: [repeatCountParam], name: "morph"),
    PickerEntry(params: [repeatCountParam], name: "flash"),
    PickerEntry(params: [repeatCountParam], name: "wobble"),
    PickerEntry(params: [repeatCountParam], name: "swing"),
    PickerEntry(params: [rotationDirectionParams, repeatCountParam], name: "rotate"),
    PickerEntry(params: [positiveNumberParam, positiveNumberParam], name: "moveby"),
    PickerEntry(params: [numberParam, numberParam], name: "moveto"),
    PickerEntry(params: [scaleParam, scaleParam], name: "scaleFrom"),
    PickerEntry(params: [scaleParam, scaleParam], name: "scaleTo"),
    PickerEntry(params: [scaleParam, scaleParam, scaleParam, scaleParam], name: "scale"),
    PickerEntry(params: [repeatCountParam], name: "spin"),
    PickerEntry(params: [animationParam, animationParam.reversed, runParam], name: "compound")
  ]
  var pickerSizeRatio: CGFloat = 0.25 {
    didSet {
      if oldValue != pickerSizeRatio {
        pickerView.setNeedsLayout()
      }
    }
  }

  var selectedEntry: PickerEntry!

  override func viewDidLoad() {
    super.viewDidLoad()
    selectedEntry = entries[0]
    pickerView.dataSource = self
    pickerView.delegate = self
    timingFunctionButton.isEnabled = true
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? AnimationsTimingFunctionViewController {
      destination.delegate = self
      destination.timingFunction = self.animatableView.timingFunction
      destination.isCubic = selectedAnimation().isCubic
    }
  }

  func selectedAnimation() -> AnimationType {
    let animationString = selectedEntry.toString(selectedIndexes: pickerView.selectedRow(inComponent: 1),
                                                 pickerView.selectedRow(inComponent: 2),
                                                 pickerView.selectedRow(inComponent: 3),
                                                 pickerView.selectedRow(inComponent: 4))
    return AnimationType(string: animationString)
  }

}

extension AnimationsViewController: TimingFunctionPickDelegate {

  func timingFunctionSelected(_ timingFunction: TimingFunctionType) {
    self.animatableView.timingFunction = timingFunction
  }

}

extension AnimationsViewController: UIPickerViewDelegate, UIPickerViewDataSource {

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return entries.count
    }
    return selectedEntry.params[safe: component - 1]?.count() ?? 0
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 5
  }

  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    switch component {
    case 0:
      return view.frame.size.width * 0.35
    case 1...4:
      return view.frame.size.width * pickerSizeRatio
    default:
      return 0
    }
  }

  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    if component == 0 {
      return entries[safe: row]?.name.colorize(.white)
    }
    guard let param = selectedEntry.params[safe: component - 1] else {
      return nil
    }
    return param.title(at: row).colorize(.white)
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0 {
      if selectedEntry.name != entries[row].name {
        selectedEntry = entries[row]
        for i in 1...4 {
          pickerView.reloadComponent(i)
        }
      }
    }
    let animationType = selectedAnimation()

    pickerView.isUserInteractionEnabled = false
    var resetTimeInterval: TimeInterval = 0.2
    if case .scale = animationType {
      resetTimeInterval = 1
      pickerSizeRatio = 0.120
    } else if case .compound = animationType {
      pickerSizeRatio = 0.20
    } else {
      pickerSizeRatio = 0.25
    }
    animatableView.animate(animationType).completion {
      if #available(iOS 10.0, *) {
        if !self.animatableView.transform.isIdentity {
          Timer.scheduledTimer(withTimeInterval: resetTimeInterval, repeats: false) { _ in
            self.resetAnimatableView()
          }
        } else {
          pickerView.isUserInteractionEnabled = true
        }
      } else {
        self.resetAnimatableView()
      }
    }
    // timingFunctionButton.isEnabled = animationType.isCubic
  }

  private func resetAnimatableView() {
    animatableView.alpha = 1
    animatableView.transform = .identity
    pickerView.isUserInteractionEnabled = true
  }

}
