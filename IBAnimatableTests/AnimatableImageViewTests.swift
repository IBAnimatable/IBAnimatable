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

  var animatableImageView: AnimatableImageView!

  override func setUp() {
    super.setUp()
    animatableImageView = AnimatableImageView()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableImageViewTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableImageView)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableImageView)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableImageViewTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableImageView)
  }

  func testOpacity() {
    _testOpacity(animatableImageView)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableImageView)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableImageView)
  }

}
