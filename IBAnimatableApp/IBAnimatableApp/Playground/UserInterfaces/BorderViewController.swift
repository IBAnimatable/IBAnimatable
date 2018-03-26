//
//  Created by jason akakpo on 13/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

private let dashLength = ParamType.number(min: 1, max: 10, interval: 1, ascending: true, unit: "")
private let dashSpaceLength = ParamType.number(min: 1, max: 10, interval: 1, ascending: true, unit: "")

final class BorderViewController: UIViewController {

  // MARK: IBOutlets

  @IBOutlet private weak var viewToBorder: AnimatableView!
  @IBOutlet private weak var topCheckBox: AnimatableCheckBox!
  @IBOutlet private weak var botCheckBox: AnimatableCheckBox!
  @IBOutlet private weak var leftCheckBox: AnimatableCheckBox!
  @IBOutlet private weak var rightCheckBox: AnimatableCheckBox!
  @IBOutlet private weak var pickerView: UIPickerView!

  // MARK: Properties

  var selectedEntry: PickerEntry!
  let entries: [PickerEntry] = [
    PickerEntry(params: [], name: "solid"),
    PickerEntry(params: [dashLength, dashSpaceLength], name: "dash")
  ]

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    selectedEntry = entries[0]
    pickerView.dataSource = self
    pickerView.delegate = self
  }

  // MARK: IBAction

  @IBAction func boxChecked(_ sender: AnimatableCheckBox) {
    let border: BorderSides
    switch sender {
    case topCheckBox:
      border = .top
    case botCheckBox:
      border = .bottom
    case leftCheckBox:
      border = .left
    case rightCheckBox:
      border = .right
    default:
      return
    }
    if sender.checked {
      viewToBorder.borderSides.insert(border)
    } else {
      viewToBorder.borderSides.remove(border)
    }
  }

}

extension BorderViewController: UIPickerViewDelegate, UIPickerViewDataSource {

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return entries.count
    }
    return selectedEntry.params[safe: component - 1]?.count() ?? 0
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
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
      }
    }

    let animationString = selectedEntry.toString(selectedIndexes: pickerView.selectedRow(inComponent: 1), pickerView.selectedRow(inComponent: 2))
    viewToBorder.borderType = BorderType(string: animationString)
  }
}
