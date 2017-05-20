//
//  AnimatableSliderTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/15/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableSliderTests: XCTestCase {

  var element = AnimatableSlider()

  override func setUp() {
    super.setUp()
    element = AnimatableSlider()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - SliderImagesDesignable Tests

extension AnimatableSliderTests: SliderImagesDesignableTests {

  func testThumbImage() {
    _testThumbImage()
  }

  func testThumbHighlightedImage() {
    _testThumbHighlightedImage()
  }

  func testMaximumTrackImage() {
    _testMaximumTrackImage()
  }

  func testMaximumTrackHighlightedImage() {
    _testMaximumTrackHighlightedImage()
  }

  func testMinimumTrackImage() {
    _testMinimumTrackImage()
  }

  func testMinimumTrackHighlightedImage() {
    _testMinimumTrackHighlightedImage()
  }

}

// MARK: - RotationDesignable Tests

extension AnimatableSliderTests: RotationDesignableTests {

  func testRotate() {
    _testRotate()
  }

}
