//  Created by phimage on 07/05/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import Foundation

import UIKit
import IBAnimatable

private let c1x = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")
private let c1y = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")
private let c2x = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")
private let c2y = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")

private let damping = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")

protocol TimingFunctionPickDelegate: NSObjectProtocol {
  func timingFunctionSelected(_ timingFunction: TimingFunctionType)
}

final class AnimationsTimingFunctionViewController: UIViewController {

  weak var delegate: TimingFunctionPickDelegate?

  var timingFunction: TimingFunctionType = .none {
    didSet {
      setTimingFunctionOnView()
    }
  }

  @IBOutlet private var timingFunctionView: TimingFunctionView!
  @IBOutlet private weak var pickerView: UIPickerView!
  @IBOutlet private weak var starView: AnimatableView!
  @IBOutlet private weak var linearView: AnimatableView!
  // prebuit common params
  let entriesCubic: [PickerEntry] = [
    PickerEntry(params: [], name: "none"),
    PickerEntry(params: [], name: "linear"),
    PickerEntry(params: [], name: "easeIn"),
    PickerEntry(params: [], name: "easeOut"),
    PickerEntry(params: [], name: "easeInOut"),
    PickerEntry(params: [], name: "default"),

    PickerEntry(params: [c1x, c1y, c2x, c2y], name: "custom"),

    PickerEntry(params: [], name: "easeInSine"), PickerEntry(params: [], name: "easeOutSine"), PickerEntry(params: [], name: "easeInOutSine"),
    PickerEntry(params: [], name: "easeInCubic"), PickerEntry(params: [], name: "easeOutCubic"), PickerEntry(params: [], name: "easeInOutCubic"),
    PickerEntry(params: [], name: "easeInQuad"), PickerEntry(params: [], name: "easeOutQuad"), PickerEntry(params: [], name: "easeInOutQuad"),
    PickerEntry(params: [], name: "easeInQuart"), PickerEntry(params: [], name: "easeOutQuart"), PickerEntry(params: [], name: "easeInOutQuart"),
    PickerEntry(params: [], name: "easeInQuint"), PickerEntry(params: [], name: "easeOutQuint"), PickerEntry(params: [], name: "easeInOutQuint"),
    PickerEntry(params: [], name: "easeInExpo"), PickerEntry(params: [], name: "easeOutExpo"), PickerEntry(params: [], name: "easeInOutExpo"),
    PickerEntry(params: [], name: "easeInCirc"), PickerEntry(params: [], name: "easeOutCirc"), PickerEntry(params: [], name: "easeInOutCirc"),
    PickerEntry(params: [], name: "easeInBack"), PickerEntry(params: [], name: "easeOutBack"), PickerEntry(params: [], name: "easeInOutBack"),

    PickerEntry(params: [damping], name: "spring")
  ]

  let entriesSpring: [PickerEntry] = [
    PickerEntry(params: [], name: "none"),
    PickerEntry(params: [], name: "linear"),
    PickerEntry(params: [], name: "easeIn"),
    PickerEntry(params: [], name: "easeOut"),
    PickerEntry(params: [], name: "easeInOut")
  ]

  var isCubic = true
  var entries: [PickerEntry] {
    return isCubic ? entriesCubic: entriesSpring
  }

  var selectedEntry: PickerEntry!

  override func viewDidLoad() {
    super.viewDidLoad()
    let index = timingFunction.pickerIndex
    if index < entries.count {
      selectedEntry = entries[index]
    } else {
      selectedEntry = entries[0]
    }
    pickerView.dataSource = self
    pickerView.delegate = self
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let index = timingFunction.pickerIndex
    pickerView.selectRow(index, inComponent: 0, animated: false)
    setTimingFunctionOnView()
  }

  private func setTimingFunctionOnView() {
    timingFunctionView?.timingFunction = timingFunction
    starView?.timingFunction = timingFunction
  }
}

extension AnimationsTimingFunctionViewController: UIPickerViewDelegate, UIPickerViewDataSource {

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
      return view.frame.size.width * 0.4
    case 1:
      return view.frame.size.width * 0.10
    case 2:
      return view.frame.size.width * 0.10
    case 3:
      return view.frame.size.width * 0.10
    case 4:
      return view.frame.size.width * 0.10
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
        pickerView.reloadComponent(1)
        pickerView.reloadComponent(2)
        pickerView.reloadComponent(3)
        pickerView.reloadComponent(4)
      }
    }
    let string = selectedEntry.toString(
      selectedIndexes:
      pickerView.selectedRow(inComponent: 1),
      pickerView.selectedRow(inComponent: 2),
      pickerView.selectedRow(inComponent: 3),
      pickerView.selectedRow(inComponent: 4)
    )
    let type = TimingFunctionType(string: string)
    self.timingFunction = type

    delegate?.timingFunctionSelected(type) // could be done only on dismiss

    linearView.timingFunction = .linear

    // make the two star fall
    pickerView.isUserInteractionEnabled = false
    starFall(starView)
    starFall(linearView) {
      self.pickerView.isUserInteractionEnabled = true
    }
  }

  private func starFall(_ view: AnimatableView, completion: (() -> Void)? = nil) {
    let moveY = view.superview?.frame.height ?? 140
    let animationType: AnimationType = isCubic ? .moveBy(x: 0, y: Double(moveY - 40)): .slide(way: .out, direction: .down)

    let animationCompletion: (() -> Void) = {
      view.transform = .identity
      completion?()
      view.setNeedsLayout()
    }

    view.animate(animationType).completion {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        animationCompletion()
      }
    }
  }

}

extension TimingFunctionType {

  var pickerIndex: Int {
    switch self {
    case .none:
      return 0
    case .linear:
      return 1
    case .easeIn:
      return 2
    case .easeOut:
      return 3
    case .easeInOut:
      return 4
    case .default:
      return 5
    case .custom:
      return 6
    case .easeInSine:
      return 7
    case .easeOutSine:
      return 8
    case .easeInOutSine:
      return 9
    case .easeInQuad:
      return 10
    case .easeOutQuad:
      return 11
    case .easeInOutQuad:
      return 12
    case .easeInCubic:
      return 13
    case .easeOutCubic:
      return 14
    case .easeInOutCubic:
      return 15
    case .easeInQuart:
      return 16
    case .easeOutQuart:
      return 17
    case .easeInOutQuart:
      return 18
    case .easeInQuint:
      return 19
    case .easeOutQuint:
      return 20
    case .easeInOutQuint:
      return 21
    case .easeInExpo:
      return 22
    case .easeOutExpo:
      return 23
    case .easeInOutExpo:
      return 24
    case .easeInCirc:
      return 25
    case .easeOutCirc:
      return 26
    case .easeInOutCirc:
      return 27
    case .easeInBack:
      return 28
    case .easeOutBack:
      return 29
    case .easeInOutBack:
      return 30
    case .spring:
      return 31
    }
  }
}
