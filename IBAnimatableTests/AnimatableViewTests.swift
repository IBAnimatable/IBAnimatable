//
//  AnimatableViewTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableViewTests: XCTestCase {

  var animatableView: AnimatableView!

  override func setUp() {
    super.setUp()
    animatableView = AnimatableView()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableViewTests: CornerDesignableTests {

  func test_cornerSides() {
    _test_cornerSides(animatableView)
  }

  func testCornerRadius() {
    _testCornerRadius(animatableView)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableViewTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableView)
  }

  func testOpacity() {
    _testOpacity(animatableView)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableView)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableView)
  }

}
