//
//  AnimatableButtonTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableButtonTests: XCTestCase {

  var animatableButton: AnimatableButton!

  override func setUp() {
    super.setUp()
    animatableButton = AnimatableButton()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableButtonTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableButton)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableButton)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableButtonTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableButton)
  }

  func testOpacity() {
    _testOpacity(animatableButton)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableButton)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableButton)
  }

}
