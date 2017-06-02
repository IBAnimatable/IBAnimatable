//
//  PaddingDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/15/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

protocol PaddingDesignableTests: class {

  associatedtype Element

  var element: Element { get set }

  func testLeftTextPadding()
  func testRightTextPadding()
  func testSideTextPadding()
  func testLeftEditPadding()
  func testRightEditPadding()
  func testSideEditPadding()
  func testLeftPlaceholderPadding()
  func testRightPlaceholderPadding()
  func testSidePlaceholderPadding()

}

// MARK: - UITextField Tests

extension PaddingDesignableTests where Element: UITextField, Element: PaddingDesignable {

  func _testLeftTextPadding() {
    testTextPadding(edge: .left(20))
  }

  func _testRightTextPadding() {
    testTextPadding(edge: .right(21))
  }

  func _testSideTextPadding() {
    testTextPadding(edge: .sides(22))
  }

  func _testLeftEditPadding() {
    testEditPadding(edge: .left(23))
  }

  func _testRightEditPadding() {
    testEditPadding(edge: .right(24))
  }

  func _testSideEditPadding() {
    testEditPadding(edge: .sides(25))
  }

  func _testLeftPlaceholderPadding() {
    testPlaceholderPadding(edge: .left(26))
  }

  func _testRightPlaceholderPadding() {
    testPlaceholderPadding(edge: .right(27))
  }

  func _testSidePlaceholderPadding() {
    testPlaceholderPadding(edge: .sides(28))
  }

  // MARK: - Test Helper Methods

  private func testTextPadding(edge: Edge) {

    let originalRect = element.textRect(forBounds: element.bounds)
    let mockRect = UIEdgeInsetsInsetRect(originalRect, edge.insets)

    switch edge {
    case .left(let padding): element.leftTextPadding = padding
    case .right(let padding): element.rightTextPadding = padding
    case .sides(let padding): element.sideTextPadding = padding
    }

    let newRect = element.textRect(forBounds: element.bounds)
    XCTAssertEqual(newRect, mockRect)

  }

  private func testEditPadding(edge: Edge) {

    let originalRect = element.editingRect(forBounds: element.bounds)
    let mockRect = UIEdgeInsetsInsetRect(originalRect, edge.insets)

    switch edge {
    case .left(let padding): element.leftEditPadding = padding
    case .right(let padding): element.rightEditPadding = padding
    case .sides(let padding): element.sideEditPadding = padding
    }

    let newRect = element.editingRect(forBounds: element.bounds)
    XCTAssertEqual(newRect, mockRect)
    print(mockRect)
    print(newRect)

  }

  private func testPlaceholderPadding(edge: Edge) {

    element.placeholder = "placeholderRect won't get called if this is nil"
    let originalRect = element.placeholderRect(forBounds: element.bounds)
    let mockRect = UIEdgeInsetsInsetRect(originalRect, edge.insets)

    switch edge {
    case .left(let padding): element.leftPlaceholderPadding = padding
    case .right(let padding): element.rightPlaceholderPadding = padding
    case .sides(let padding): element.sidePlaceholderPadding = padding
    }

    let newRect = element.placeholderRect(forBounds: element.bounds)
    XCTAssertEqual(newRect, mockRect)

  }

}

// MARK: - Helper Enum

fileprivate enum Edge {
  case left(CGFloat)
  case right(CGFloat)
  case sides(CGFloat)

  var insets: UIEdgeInsets {
    switch self {
    case .left(let value): return UIEdgeInsets(top: 0, left: value, bottom: 0, right: 0)
    case .right(let value): return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: value)
    case .sides(let value): return UIEdgeInsets(top: 0, left: value, bottom: 0, right: value)
    }
  }

}
