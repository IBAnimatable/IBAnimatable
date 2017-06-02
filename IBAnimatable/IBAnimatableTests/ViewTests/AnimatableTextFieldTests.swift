//
//  AnimatableTextFieldTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

class AnimatableTextFieldTests: XCTestCase {

  var element = AnimatableTextField()

  override func setUp() {
    super.setUp()
    element = AnimatableTextField()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableTextFieldTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius()
  }

  func test_cornerSides() {
    _test_cornerSides()
  }

}

// MARK: - FillDesignable Tests

extension AnimatableTextFieldTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor()
  }

  func testOpacity() {
    _testOpacity()
  }

  func testPredefinedColor() {
    _testPredefinedColor()
  }

  func test_predefinedColor() {
    _test_predefinedColor()
  }

}

// MARK: - PaddingDesignable Tests

extension AnimatableTextFieldTests: PaddingDesignableTests {

  func testRightTextPadding() {
    _testRightTextPadding()
  }

  func testLeftTextPadding() {
    _testLeftTextPadding()
  }

  func testSideTextPadding() {
    _testSideTextPadding()
  }

  func testRightPlaceholderPadding() {
    _testRightPlaceholderPadding()
  }

  func testLeftPlaceholderPadding() {
    _testLeftPlaceholderPadding()
  }

  func testSidePlaceholderPadding() {
    _testSidePlaceholderPadding()
  }

  func testRightEditPadding() {
    _testRightEditPadding()
  }

  func testLeftEditPadding() {
    _testLeftEditPadding()
  }

  func testSideEditPadding() {
    _testSideEditPadding()
  }

}
