//
//  AnimatableScrollViewTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableScrollViewTests: XCTestCase {

  var animatableScrollView: AnimatableScrollView!

  override func setUp() {
    super.setUp()
    animatableScrollView = AnimatableScrollView()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableScrollViewTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableScrollView)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableScrollView)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableScrollViewTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableScrollView)
  }

  func testOpacity() {
    _testOpacity(animatableScrollView)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableScrollView)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableScrollView)
  }

}

// MARK: - RotationDesignable Tests

extension AnimatableScrollViewTests: RotationDesignableTests {

  func testRotate() {
    _testRotate(animatableScrollView)
  }

}
