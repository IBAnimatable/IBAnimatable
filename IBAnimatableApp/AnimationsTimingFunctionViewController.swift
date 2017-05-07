//  Created by phimage on 07/05/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import Foundation

import UIKit
import IBAnimatable

fileprivate let c1x = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")
fileprivate let c1y = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")
fileprivate let c2x = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")
fileprivate let c2y = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")

fileprivate let damping = ParamType.number(min: 0, max: 1, interval: 0.1, ascending: true, unit: "")

protocol TimingFunctionPickDelegate: NSObjectProtocol {
  func timingFunctionSelected(_ timingFunction: TimingFunctionType)
}

class AnimationsTimingFunctionViewController: UIViewController {

  weak var delegate: TimingFunctionPickDelegate?

  @IBOutlet var timingFunctionView: TimingFunctionView!
  @IBOutlet weak var pickerView: UIPickerView!
  // prebuit common params
  let entries: [PickerEntry] = [
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

  var selectedEntry: PickerEntry!
  override func viewDidLoad() {
    super.viewDidLoad()
    selectedEntry = entries[0]
    pickerView.dataSource = self
    pickerView.delegate = self
  }
}

extension AnimationsTimingFunctionViewController : UIPickerViewDelegate, UIPickerViewDataSource {

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
    let animationString = selectedEntry.toString(
      selectedIndexes:
      pickerView.selectedRow(inComponent: 1),
      pickerView.selectedRow(inComponent: 2),
      pickerView.selectedRow(inComponent: 3),
      pickerView.selectedRow(inComponent: 4)
    )
    let type = TimingFunctionType(string: animationString)
    timingFunctionView.timingFunction = type
    delegate?.timingFunctionSelected(type)
  }

}
