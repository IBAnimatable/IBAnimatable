//
//  AnimatableLabelTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableLabelTests: XCTestCase {

  var animatableLabel: AnimatableLabel!

  override func setUp() {
    super.setUp()
    animatableLabel = AnimatableLabel()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableLabelTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableLabel)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableLabel)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableLabelTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableLabel)
  }

  func testOpacity() {
    _testOpacity(animatableLabel)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableLabel)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableLabel)
  }

}

// MARK: - RotationDesignable Tests

extension AnimatableLabelTests: RotationDesignableTests {

  func testRotate() {
    _testRotate(animatableLabel)
  }

}
