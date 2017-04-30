//
//  BorderDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 4/30/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

class BorderDesignableTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testBorderType() {

  }

  func test_borderType() {
    helper_test_borderType(element: AnimatableView())
    helper_test_borderType(element: AnimatableScrollView())
    helper_test_borderType(element: AnimatableButton())
    helper_test_borderType(element: AnimatableCheckBox())
    helper_test_borderType(element: AnimatableImageView())
    helper_test_borderType(element: AnimatableLabel())
    helper_test_borderType(element: AnimatableStackView())
    helper_test_borderType(element: AnimatableTableView())
    helper_test_borderType(element: AnimatableTableViewCell())
    helper_test_borderType(element: AnimatableCollectionViewCell())
    helper_test_borderType(element: AnimatableTextView())
    helper_test_borderType(element: AnimatableTextField())
    helper_test_borderType(element: AnimatableSlider())
  }

  private func helper_test_borderType(element: MockUIViewBorderDesignable) {
    element._borderType = "solid"
    XCTAssertEqual(element.borderType, .solid)
    element._borderType = "dash"
    XCTAssertEqual(element.borderType, .dash(dashLength: 0, spaceLength: 0))
    element._borderType = "none"
    XCTAssertEqual(element.borderType, .none)
    element._borderType = nil
    XCTAssertEqual(element.borderType, .none)
  }

  func testBorderColor() {

  }

  func testBorderWidth() {

  }

  func testBorderSides() {

  }

  func test_borderSides() {
    
  }
  
  private func helper_test_borderSides(element: MockUIViewBorderDesignable) {

  }
}

// MARK: - MockUIViewBorderDesignable

fileprivate protocol MockUIViewBorderDesignable: class, BorderDesignable {

  var _borderType: String? { get set }
  var _borderSides: String? { get set }

}

// MARK: - Classes with BorderDesignable conformance

extension AnimatableView: MockUIViewBorderDesignable {}
extension AnimatableScrollView: MockUIViewBorderDesignable {}
extension AnimatableButton: MockUIViewBorderDesignable {}
extension AnimatableCheckBox: MockUIViewBorderDesignable {}
extension AnimatableImageView: MockUIViewBorderDesignable {}
extension AnimatableLabel: MockUIViewBorderDesignable {}
extension AnimatableStackView: MockUIViewBorderDesignable {}
extension AnimatableTableView: MockUIViewBorderDesignable {}
extension AnimatableTableViewCell: MockUIViewBorderDesignable {}
extension AnimatableCollectionViewCell: MockUIViewBorderDesignable {}
extension AnimatableTextField: MockUIViewBorderDesignable {}
extension AnimatableTextView: MockUIViewBorderDesignable {}
extension AnimatableSlider: MockUIViewBorderDesignable {}
