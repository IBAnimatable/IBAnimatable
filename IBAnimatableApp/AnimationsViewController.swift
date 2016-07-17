//
//  AnimationsViewController.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 12/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

internal extension String {
  func colorize(color:UIColor) -> AttributedString {
    return AttributedString(string:self, attributes: [NSForegroundColorAttributeName:color])
  }
}

internal extension Array {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript(safe index: Int ) -> Element? {
    return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  }
}

enum ParamType {
 // case string
  case number(min: Double, max: Double, interval: Double)
  case enumeration(values: [String])
  
   /// Number of different values to show in the picker row
  func count() -> Int {
    switch self {
    case .number(let min, let max, let interval):
      return Int(ceil(max - min / interval) + 1)
    case .enumeration(let val):
      return val.count
    }
  }

  func titleAt(index:Int) -> String? {
    switch self {
    case .enumeration(let values):
      return values[safe:index]
    case .number(let min,  _, let interval):
      return String(min + Double(index) * interval)
    }

  }
}


struct Entry {
  let params: [ParamType]
  let name:String
 
 }

class AnimationsViewController: UIViewController {
  
  @IBOutlet weak var aView: AnimatableView!
  @IBOutlet weak var oldAView: AnimatableOldView!
  @IBOutlet weak var pickerView: UIPickerView!
  
  // prebuit common params
  let wayParam = ParamType.enumeration(values: ["in", "out"])
  let directionParam = ParamType.enumeration(values: ["left", "right", "up", "down", "none"])
  let axisParams = ParamType.enumeration(values: ["X", "Y"])
  let rotationDirectionParams = ParamType.enumeration(values: ["Cw", "CCW"])
  var entries:[Entry]!
  var selectedEntry:Entry!
  let positiveNumberParam = ParamType.number(min: 0, max: 50, interval: 2)
  let numberParam = ParamType.number(min: -50, max: 50, interval: 5)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
     entries = [
      Entry(params:[wayParam, directionParam], name: "slide"),
      Entry(params:[wayParam, directionParam], name: "squeeze"),
      Entry(params:[wayParam, directionParam], name: "fade"),
      Entry(params:[wayParam, directionParam], name: "squeezeFade"),
      Entry(params:[wayParam], name: "zoom"),
      Entry(params:[axisParams], name: "flip"),
      Entry(params:[], name: "flash"),
      Entry(params:[], name: "wobble"),
      Entry(params:[], name: "swing"),
      Entry(params:[rotationDirectionParams], name: "rotate"),
      Entry(params: [positiveNumberParam, positiveNumberParam], name: "moveby"),
      Entry(params: [numberParam, numberParam], name: "moveto")
    ]
    selectedEntry = entries[0]
    pickerView.dataSource = self
    pickerView.delegate = self
  }
  func toString() -> String {
    let name = selectedEntry.name.lowercased()
    
    var paramArray:[String] = [selectedEntry.params[safe:0]?.titleAt(index:pickerView.selectedRow(inComponent: 1)) ?? ""]
    let secondVal = selectedEntry.params[safe:1]?.titleAt(index:pickerView.selectedRow(inComponent: 2))
    if let secondVal = secondVal {
      paramArray.append(secondVal)
    }
    let paramString:String = paramArray.joined(separator: ",").lowercased()
   return "\(name)(\(paramString))"
  }
  func toOldString() -> String {
    let name = selectedEntry.name
    
    var paramArray:[String] = [selectedEntry.params[safe:0]?.titleAt(index:pickerView.selectedRow(inComponent: 1)) ?? ""]
    let secondVal = selectedEntry.params[safe:1]?.titleAt(index:pickerView.selectedRow(inComponent: 2))
    if let secondVal = secondVal {
      paramArray.append(secondVal)
    }
    let paramString:String = paramArray.map({ $0.capitalized }).joined(separator: "")
    return name.appending(paramString)
    
  }
}

extension AnimationsViewController : UIPickerViewDelegate, UIPickerViewDataSource {
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return entries.count
    }
    return selectedEntry.params[safe:component - 1]?.count() ?? 0
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> AttributedString? {
    
    if component == 0 {
      return entries[safe:row]?.name.colorize(color: .white())
}
    guard let param = selectedEntry.params[safe:component - 1] else {
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
    let animationString = toString();
    print(animationString)
    let animType = AnimationType(string: toString());
   // print(animType)
    pickerView.isUserInteractionEnabled = false
    oldAView.animationType = toOldString()
    oldAView.animate()
    aView.animate(animType) {
      if #available(iOS 10.0, *) {
        if !self.aView.transform.isIdentity  || !self.oldAView.transform.isIdentity {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
          self.oldAView.alpha = 1;
          self.aView.alpha = 1;
          self.oldAView.transform = CGAffineTransform.identity
          self.aView.transform = CGAffineTransform.identity
          self.pickerView.isUserInteractionEnabled = true
        }
        }
        else {
          self.pickerView.isUserInteractionEnabled = true
        }
      }
    }
    
  }
  
}
