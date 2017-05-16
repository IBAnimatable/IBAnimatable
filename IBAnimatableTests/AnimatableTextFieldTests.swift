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

  var animatableTextField: AnimatableTextField!

  override func setUp() {
    super.setUp()
    animatableTextField = AnimatableTextField()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableTextFieldTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableTextField)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableTextField)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableTextFieldTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableTextField)
  }

  func testOpacity() {
    _testOpacity(animatableTextField)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableTextField)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableTextField)
  }

}

// MARK: - PaddingDesignable Tests

extension AnimatableTextFieldTests: PaddingDesignableTests {

  func testPaddingLeft() {
    _testPaddingLeft(animatableTextField)
  }
  
  func testPaddingRight() {
    _testPaddingRight(animatableTextField)
  }
  
  func testPaddingSide() {
    _testPaddingSide(animatableTextField)
  }
  
}
