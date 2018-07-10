//
//  Created by jason akakpo on 27/07/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation
import UIKit

extension String {
  /// Returns `NSAttributedString` with specified color.
  func colorize(_ color: UIColor) -> NSAttributedString {
    return NSAttributedString(string: self, attributes: [.foregroundColor: color])
  }
}

extension Array {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript(safe index: Int) -> Element? {
    return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  }
}

enum ParamType {

  case number(min: Double, max: Double, interval: Double, ascending: Bool, unit: String)
  case enumeration(values: [String])

  #if swift(>=4.2)
  init<T: RawRepresentable>(fromEnum: T.Type) where T: CaseIterable {
    let iterator = iterateEnum(fromEnum)
    let values = iterator.map { String(describing: $0.rawValue) }
    self = .enumeration(values: values)
  }
  #else
  init<T: RawRepresentable>(fromEnum: T.Type) where T: Hashable {
    let iterator = iterateEnum(fromEnum)
    let values = iterator.map { String(describing: $0.rawValue) }
    self = .enumeration(values: values)
  }
  #endif

  /// Number of different values to show in the picker
  func count() -> Int {
    switch self {
    case let .number(min, max, interval, _, _):
      return Int(ceil((max - min) / interval) + 1)
    case .enumeration(let val):
      return val.count
    }
  }
  /// Number at Index, use just for number case.
  func value(at index: Int) -> String {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 3

    switch self {
    case let .number(min, _, interval, ascending, _) where ascending == true:
      return formatter.string(from: NSNumber(value: min + Double(index) * interval))!
    case let .number(_, max, interval, _, _):
      return formatter.string(from: NSNumber(value: max - Double(index) * interval))!
    case let .enumeration(values):
      return values[safe: index] ?? ""
    }
  }

  func title(at index: Int) -> String {
    switch self {
    case .enumeration:
      return value(at: index)
    case let .number(_, _, _, _, unit):
      return   ("\(value(at: index)) \(unit)").trimmingCharacters(in: CharacterSet.whitespaces)
    }
  }

  var reversed: ParamType {
    switch self {
    case .number(let min, let max, let interval, let ascending, let unit):
      return .number(min: min, max: max, interval: interval, ascending: !ascending, unit: unit)
    case .enumeration(let values):
      return .enumeration(values: values.reversed())
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

    let paramString = indexes.enumerated().compactMap({ (val: (Int, Int?)) -> String? in let (i, index) = val
      return params[safe:i]?.value(at: index ?? 0)
    }).joined(separator: ",")

    return "\(name)(\(paramString))"

  }
}
