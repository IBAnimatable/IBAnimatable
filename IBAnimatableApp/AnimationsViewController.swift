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
 
  init<T: RawRepresentable where T: Hashable>(fromEnum: T.Type) {
    let iterator = iterateEnum(fromEnum)
    let values = iterator.map {  return String($0.rawValue) }
    self = .enumeration(values: values)
  }
  
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

private let wayParam = ParamType(fromEnum: AnimationType.Way.self)
private let directionParam = ParamType(fromEnum: AnimationType.Direction.self)
private let fadeWayParams = ParamType(fromEnum: AnimationType.FadeWay.self)
private let axisParams = ParamType(fromEnum: AnimationType.Axis.self)
private let rotationDirectionParams = ParamType(fromEnum: AnimationType.RotationDirection.self)
private let positiveNumberParam = ParamType.number(min: 0, max: 50, interval: 2)
private let numberParam = ParamType.number(min: -50, max: 50, interval: 5)

class AnimationsViewController: UIViewController {
  
  @IBOutlet weak var aView: AnimatableView!
  @IBOutlet weak var pickerView: UIPickerView!
  
  
  // prebuit common params
  let entries: [Entry] = [
    Entry(params: [wayParam, directionParam], name: "slide"),
    Entry(params: [wayParam, directionParam], name: "squeeze"),
    Entry(params: [fadeWayParams], name: "fade"),
    Entry(params: [wayParam, directionParam], name: "slideFade"),
    Entry(params: [wayParam, directionParam], name: "squeezeFade"),
    Entry(params: [wayParam], name: "zoom"),
    Entry(params: [axisParams], name: "flip"),
    Entry(params: [], name: "flash"),
    Entry(params: [], name: "wobble"),
    Entry(params: [], name: "swing"),
    Entry(params: [rotationDirectionParams], name: "rotate"),
    Entry(params: [positiveNumberParam, positiveNumberParam], name: "moveby"),
    Entry(params: [numberParam, numberParam], name: "moveto")
    ]
  
  
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
