//
//  AnimatableImageViewTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableImageViewTests: XCTestCase {

  var element = AnimatableImageView()

  override func setUp() {
    super.setUp()
    element = AnimatableImageView()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableImageViewTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius()
  }

  func test_cornerSides() {
    _test_cornerSides()
  }

}

// MARK: - FillDesignable Tests

extension AnimatableImageViewTests: FillDesignableTests {

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

// MARK: - RotationDesignable Tests

extension AnimatableImageViewTests: RotationDesignableTests {

  func testRotate() {
    _testRotate()
  }

}
