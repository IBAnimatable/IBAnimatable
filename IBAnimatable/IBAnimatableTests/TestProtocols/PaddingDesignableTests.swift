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

  func testPaddingLeft()
  func testPaddingRight()
  func testPaddingSide()

}

// MARK: - UITextField Tests

extension PaddingDesignableTests where Element: UITextField, Element: PaddingDesignable {

  func _testPaddingLeft() {
    testPadding(on: .left(20))
  }

  func _testPaddingRight() {
    testPadding(on: .right(40))
  }

  func _testPaddingSide() {
    testPadding(on: .sides(60))
  }

  // MARK: - Helper Methods

  private func testPadding(on edge: Edge) {
    element.placeholder = "placeholderRect will not be called if this is nil"
    let textRectOriginal = element.textRect(forBounds: element.bounds)
    let editRectOriginal = element.editingRect(forBounds: element.bounds)
    let placeholderRectOriginal = element.placeholderRect(forBounds: element.bounds)

    switch edge {
    case .left(let padding): element.paddingLeft = padding
    case .right(let padding): element.paddingRight = padding
    case .sides(let padding): element.paddingSide = padding
    }

    let paddedTextRect = element.textRect(forBounds: element.bounds)
    let paddedEditRect = element.editingRect(forBounds: element.bounds)
    let paddedPlaceholderRect = element.placeholderRect(forBounds: element.bounds)

    let mockTextRect = textRectOriginal.inset(by: edge.insets)
    let mockEditRect = editRectOriginal.inset(by: edge.insets)
    let mockPlaceholderRect = placeholderRectOriginal.inset(by: edge.insets)

    XCTAssertEqual(paddedTextRect, mockTextRect)
    XCTAssertEqual(paddedEditRect, mockEditRect)
    XCTAssertEqual(paddedPlaceholderRect, mockPlaceholderRect)
  }

}

// MARK: - Helper Enum

private enum Edge {
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
