//
//  Created by jason akakpo on 03/07/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation
import UIKit

extension Array {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript(safe index: Int) -> Element? {
    return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  }
}

extension Array where Element: Udra.Node {

  // MARK: String
  func toString(_ index: Int) -> String? {
    if let node = self[safe: index] as? Udra.VariableNode {
      return node.name
    }
    return nil
  }

  func contains(_ name: String) -> Bool {
    for node in self where node.name == name {
      return true
    }
    return false
  }

  // MARK: Number
  fileprivate func numberNode(at index: Int) -> Udra.NumberNode? {
    var node: Udra.Node? = self[safe: index]
    if let operatorNode = node as? Udra.BinaryOperatorNode,
      let evaluate = operatorNode.evaluate() as? Udra.NumberNode {
      node = evaluate
    }
    return node as? Udra.NumberNode
  }

  func toDouble(_ index: Int) -> Double? {
    if let node = numberNode(at: index) {
      return node.value
    }
    return nil
  }
  func toDoubles() -> [Double] {
    let nodes = self.compactMap { $0 as? Udra.NumberNode }
    return nodes.map { Double($0.value) }
  }

  func toInt(_ index: Int) -> Int? {
    if let node = numberNode(at: index) {
      return Int(node.value)
    }
    return nil
  }
  func toFloat(_ index: Int) -> Float? {
    if let node = numberNode(at: index) {
      return Float(node.value)
    }
    return nil
  }
  func toCGFloat(_ index: Int) -> CGFloat? {
    if let node = numberNode(at: index) {
      return CGFloat(node.value)
    }
    return nil
  }
  func toBool(_ index: Int) -> Bool? {
    if let node = self[safe: index] as? Udra.NumberNode {
      return node.value != 0
    }
    if let node = self[safe: index] as? Udra.VariableNode, let value = Bool(node.name) {
      return value
    }
    return nil
  }

}

extension RawRepresentable {

  init?(raw: RawValue?) {
    guard let raw = raw else {
      return nil
    }
    self.init(rawValue: raw)
  }

  init(raw: RawValue?, defaultValue: Self) {
    guard let value = raw  else {
      self = defaultValue
      return
    }
    self = Self(rawValue: value) ?? defaultValue
  }
}

#if swift(>=4.2)
func iterateEnum<T: CaseIterable>(from: T.Type) -> AnyIterator<T> {
  return AnyIterator(T.allCases.makeIterator())
}
#else
func iterateEnum<T: Hashable>(from: T.Type) -> AnyIterator<T> {
  var x = 0
  return AnyIterator {
    let next = withUnsafePointer(to: &x) {
      $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
    }
    defer {
      x += 1
    }
    return next.hashValue == x ? next : nil
  }
}
#endif

extension String {

  func parseNameAndParams() -> [Udra.Node] {
    let parser = Udra.Parser(tokens: Udra.Lexer.tokenize(self.lowercased()))
    do {
      return try parser.parse()
    } catch {
      #if DEBUG
      print("Failed to parse \"\(self)\", error: \(error)")
      #endif
      return []
    }
  }

  /**
   Helper function that returns a tuple containing the name and params from a string
   
   - Parameter from string: The string to be converted into `enum`.
   - Discussion: the string format is like "enumName(param1,param2,param3)"
   - Returns: A tuple containing the name and an array of parameter string
   */
  func extractNameAndParams() -> (String, [Udra.Node])? {
    let nodes = self.parseNameAndParams()
    guard let firstNode = nodes.first else {
      return nil
    }
    let params: [Udra.Node] = (firstNode as? Udra.CallNode)?.arguments ?? []
    return (firstNode.name, params)
  }

  public func parse<T: IBEnum>() -> T? {
    return T(string: self)
  }

  public func parse<T: IBEnum>(default defaultValue: T) -> T {
    return T(string: self) ?? defaultValue
  }

}

extension NSRegularExpression {

  func matched(_ string: String) -> (String, CountableRange<Int>)? {
    let range = self.rangeOfFirstMatch(in: string, options: [], range: NSRange(0 ..< string.utf16.count))
    if range.location != NSNotFound {
      return ((string as NSString).substring(with: range), range.location ..< range.location + range.length)
    }
    return nil
  }
}
