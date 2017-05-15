//
//  AnimatableStackViewTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableStackViewTests: XCTestCase {

  var animatableStackView: AnimatableStackView!

  override func setUp() {
    super.setUp()
    animatableStackView = AnimatableStackView()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableStackViewTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableStackView)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableStackView)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableStackViewTests: FillDesignableTests {

  func testFillColor() {
    //_testFillColor(animatableStackView) // broken see issue #461
  }

  func testOpacity() {
    //_testOpacity(animatableStackView) // broken see issue #461
  }

  func testPredefinedColor() {
    //_testPredefinedColor(animatableStackView) // broken see issue #461
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableStackView)
  }

}
