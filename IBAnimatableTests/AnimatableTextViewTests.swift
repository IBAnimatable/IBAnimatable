//
//  AnimatableTextViewTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

class AnimatableTextViewTests: XCTestCase {

  var animatableTextView: AnimatableTextView!

  override func setUp() {
    super.setUp()
    animatableTextView = AnimatableTextView()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableTextViewTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableTextView)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableTextView)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableTextViewTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableTextView)
  }

  func testOpacity() {
    _testOpacity(animatableTextView)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableTextView)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableTextView)
  }

}
