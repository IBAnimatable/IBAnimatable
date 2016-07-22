//
//  AnimationsViewController.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 12/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

extension String {
  func colorize(color: UIColor) -> AttributedString {
    return AttributedString(string: self, attributes: [NSForegroundColorAttributeName: color])
  }
}

extension Array {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript(safe index: Int ) -> Element? {
    return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  }
}

enum ParamType {
  
  case number(min: Double, max: Double, interval: Double)
  case enumeration(values: [String])
  
  /// Number of different values to show in the picker
  func count() -> Int {
    switch self {
    case .number(let min, let max, let interval):
      return Int(ceil(max - min / interval) + 1)
    case .enumeration(let val):
      return val.count
    }
  }
  
  func titleAt(index: Int) -> String? {
    switch self {
    case .enumeration(let values):
      return values[safe: index]
    case .number(let min, _, let interval):
      return String(min + Double(index) * interval)
    }
    
  }
}


struct Entry {
  let params: [ParamType]
  let name: String
}

extension Entry {
  /// Convert the entry to a `AnimationType` string
  func toString(selectedIndexes indexes: Int?...) -> String {
    
    let paramString = indexes.enumerated().flatMap({ (i: Int, index: Int?) -> String? in
      return params[safe:i]?.titleAt(index: index ?? 0)
    }).joined(separator: ",")
    
    return "\(name)(\(paramString))"
    
  }
}

class AnimationsViewController: UIViewController {
  
  @IBOutlet weak var aView: AnimatableView!
  @IBOutlet weak var pickerView: UIPickerView!
  
  let positiveNumberParam = ParamType.number(min: 0, max: 50, interval: 2)
  let numberParam = ParamType.number(min: -50, max: 50, interval: 5)
  
  // prebuit common params
  let wayParam = ParamType.enumeration(values: ["in", "out"])
  let directionParam = ParamType.enumeration(values: ["left", "right", "up", "down"])
  let fadeParams = ParamType.enumeration(values: ["in", "out", "inOut", "outIn"])
  let axisParams = ParamType.enumeration(values: ["X", "Y"])
  let rotationDirectionParams = ParamType.enumeration(values: ["Cw", "CCW"])
  lazy var entries: [Entry] = {[
    Entry(params: [self.wayParam, self.directionParam], name: "slide"),
    Entry(params: [self.wayParam, self.directionParam], name: "squeeze"),
    Entry(params: [self.fadeParams], name: "fade"),
    Entry(params: [self.wayParam, self.directionParam], name: "slideFade"),
    Entry(params: [self.wayParam, self.directionParam], name: "squeezeFade"),
    Entry(params: [self.wayParam], name: "zoom"),
    Entry(params: [self.axisParams], name: "flip"),
    Entry(params: [], name: "flash"),
    Entry(params: [], name: "wobble"),
    Entry(params: [], name: "swing"),
    Entry(params: [self.rotationDirectionParams], name: "rotate"),
    Entry(params: [self.positiveNumberParam, self.positiveNumberParam], name: "moveby"),
    Entry(params: [self.numberParam, self.numberParam], name: "moveto")
    ]
  }()
  
  var selectedEntry: Entry!
  override func viewDidLoad() {
    super.viewDidLoad()
    selectedEntry = entries[0]
    pickerView.dataSource = self
    pickerView.delegate = self
  }
  
}

extension AnimationsViewController : UIPickerViewDelegate, UIPickerViewDataSource {
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return entries.count
    }
    return selectedEntry.params[safe: component - 1]?.count() ?? 0
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> AttributedString? {
    
    if component == 0 {
      return entries[safe: row]?.name.colorize(color: .white())
    }
    guard let param = selectedEntry.params[safe: component - 1] else {
      return nil
    }
    return param.titleAt(index: row)?.colorize(color: .white())
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0 {
      if selectedEntry.name != entries[row].name {
        selectedEntry = entries[row]
        pickerView.reloadComponent(1)
        pickerView.reloadComponent(2)
      }
    }
    let animString = selectedEntry.toString(selectedIndexes: pickerView.selectedRow(inComponent: 1), pickerView.selectedRow(inComponent: 2))
    let animType = AnimationType(string: animString)
    pickerView.isUserInteractionEnabled = false
    aView.animate(animType) {
      if #available(iOS 10.0, *) {
        if !self.aView.transform.isIdentity {
          Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
            self.aView.alpha = 1
            self.aView.transform = CGAffineTransform.identity
            self.pickerView.isUserInteractionEnabled = true
          }
        } else {
          self.pickerView.isUserInteractionEnabled = true
        }
      }
    }
    
  }
  
}
