//
//  FillDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 4/25/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

class FillDesignableTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - testFillColor

  func testFillColor() {
    helper_testFillColor_UIView(element: AnimatableView())
    helper_testFillColor_UIView(element: AnimatableScrollView())
    helper_testFillColor_UIView(element: AnimatableButton())
    helper_testFillColor_UIView(element: AnimatableCheckBox())
    helper_testFillColor_UIView(element: AnimatableImageView())
    //helper_testFillColor_UIView(element: AnimatableStackView()) // broken see #461
    helper_testFillColor_UIView(element: AnimatableTableView())
    helper_testFillColor_UIView(element: AnimatableTextField())
    helper_testFillColor_UIView(element: AnimatableTextView())
    helper_testFillColor_Cell(element: AnimatableTableViewCell())
    //helper_testFillColor_Cell(element: AnimatableCollectionViewCell())
  }

  private func helper_testFillColor_UIView(element: MockUIViewFillDesignable) {
    var element = element
    element.fillColor = .red
    XCTAssertEqual(element.backgroundColor, .red)
  }

  private func helper_testFillColor_Cell(element: MockCellFillDesignable) {
    var element = element
    element.fillColor = .red
    XCTAssertEqual(element.backgroundColor, .red)
    XCTAssertEqual(element.contentView.backgroundColor, .red)
  }
  
  // MARK: - testOpacity
  
  func testOpacity() {
    
  }

}

// MARK: - MockFillDesignable

fileprivate protocol MockUIViewFillDesignable: class, FillDesignable {

  var _predefinedColor: String? { get set }
  var backgroundColor: UIColor? { get set }

}

fileprivate protocol MockCellFillDesignable: class, MockUIViewFillDesignable, FillDesignable {

  var contentView: UIView { get }

}

// MARK: - Classes with FillDesignable conformance

extension AnimatableView: MockUIViewFillDesignable {}
extension AnimatableScrollView: MockUIViewFillDesignable {}
extension AnimatableButton: MockUIViewFillDesignable {}
extension AnimatableCheckBox: MockUIViewFillDesignable {}
extension AnimatableImageView: MockUIViewFillDesignable {}
extension AnimatableStackView: MockUIViewFillDesignable {}
extension AnimatableTableView: MockUIViewFillDesignable {}
extension AnimatableTableViewCell: MockCellFillDesignable {}
extension AnimatableCollectionViewCell: MockCellFillDesignable {}
extension AnimatableTextView: MockUIViewFillDesignable {}
extension AnimatableTextField: MockUIViewFillDesignable {}
