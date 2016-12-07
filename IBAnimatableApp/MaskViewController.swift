//
//  Created by Jake Lin on 6/29/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

class MaskViewController: UIViewController {

  @IBOutlet var maskedView: AnimatableView!
  // @IBOutlet var maskedImageView: AnimatableImageView!
  @IBOutlet weak var pickerView: UIPickerView!
  var selectedEntry: PickerEntry!
  lazy var entries: [PickerEntry] = {
    let pointsParam = ParamType.number(min: 3, max: 10, interval: 1, ascending: true, unit: "points") // default 5
    let sidesParam = ParamType.number(min: 3, max: 10, interval: 1, ascending: true, unit: "sides") // default 6
    let angleParam = ParamType.number(min: 60, max: 120, interval: 2, ascending: true, unit: "°") // default 6
    let waveParam = ParamType(fromEnum: MaskType.WaveDirection.self)
    let widthParam = ParamType.number(min: 15, max: 90, interval: 2, ascending: true, unit: "px")

    return [PickerEntry(params:[], name:"circle"),
            PickerEntry(params:[sidesParam], name: "polygon"),
            PickerEntry(params:[pointsParam], name: "star"),
            PickerEntry(params:[waveParam, widthParam], name: "wave"),
            PickerEntry(params:[angleParam], name: "parallelogram"),
            PickerEntry(params:[], name: "none")
    ]
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    selectedEntry = entries[0]
    pickerView.delegate = self
    pickerView.dataSource = self
    let maskString = selectedEntry.toString(selectedIndexes:0)
    let maskType = MaskType(string: maskString)
    maskedView.maskType = maskType
  }
}

extension MaskViewController : UIPickerViewDelegate, UIPickerViewDataSource {

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return entries.count
    }
    return selectedEntry.params[safe: component - 1]?.count() ?? 0
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }

  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {

    // the goal of this is to mask useless components
    switch component {
    case 0:
      return self.view.frame.size.width * 0.5
    case let c where c > selectedEntry.params.count:
      return 0
    default:
      return self.view.frame.size.width * 0.25
    }
  }

  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = UILabel()
    label.textColor = .white
    if component == 0 {
      label.text = entries[safe: row]?.name
    } else {
      label.text = selectedEntry.params[safe: component - 1]?.title(at: row)
    }
    return label

  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0 {
      if selectedEntry.name != entries[row].name {
        selectedEntry = entries[row]
        pickerView.reloadComponent(1)
        pickerView.reloadComponent(2)
        pickerView.setNeedsLayout() // trick to re-ask for components width
      }
    }
    let maskString = selectedEntry.toString(selectedIndexes: pickerView.selectedRow(inComponent: 1), pickerView.selectedRow(inComponent: 2))
    maskedView.maskType = MaskType(string: maskString)
  }
}
