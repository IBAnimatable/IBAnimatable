//
//  ParamType.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 27/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation
import UIKit


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
  
  case number(min: Double, max: Double, interval: Double, ascending: Bool, unit: String)
  case enumeration(values: [String])
  
  init<T: RawRepresentable where T: Hashable>(fromEnum: T.Type) {
    let iterator = iterateEnum(from: fromEnum)
    let values = iterator.map {  return String($0.rawValue) }
    self = .enumeration(values: values)
  }
  
  /// Number of different values to show in the picker
  func count() -> Int {
    switch self {
    case .number(let min, let max, let interval, _, _):
      return Int(ceil((max - min) / interval) + 1)
    case .enumeration(let val):
      return val.count
    }
  }
  /// Number at Index, use just for number case.
  func valueAt(index: Int) -> String  {
    let formatter = NumberFormatter();
    formatter.minimumFractionDigits = 0;
  
    switch self {
    case let .number(min, _, interval, ascending, _) where ascending == true:
      return formatter.string(from: min + Double(index) * interval)!
    case let .number(_, max, interval, _, _):
      return formatter.string(from: max - Double(index) * interval)!
    case let .enumeration(values):
      return values[safe: index] ?? ""
    }
  }
  
  func titleAt(index: Int) -> String {
    switch self {
    case enumeration(_):
      return valueAt(index: index)
    case let .number(_, _, _, _, unit):
      return   ("\(valueAt(index: index)) \(unit)").trimmingCharacters(in: CharacterSet.whitespaces)
    }
  }
}


struct PickerEntry {
  let params: [ParamType]
  let name: String
}

extension PickerEntry {
  /// Convert the entry to a `AnimationType` string
  func toString(selectedIndexes indexes: Int?...) -> String {
    
    let paramString = indexes.enumerated().flatMap({ (i: Int, index: Int?) -> String? in
      return params[safe:i]?.valueAt(index: index ?? 0)
    }).joined(separator: ",")
    
    return "\(name)(\(paramString))"
    
  }
}


