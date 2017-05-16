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

  var animatableSlider: AnimatableSlider!

  override func setUp() {
    super.setUp()
    animatableSlider = AnimatableSlider()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - AnimatableSlider Tests

extension AnimatableSliderTests: SliderImagesDesignableTests {

  func testThumbImage() {
    _testThumbImage(animatableSlider)
  }

  func testThumbHighlightedImage() {
    _testThumbHighlightedImage(animatableSlider)
  }

  func testMaximumTrackImage() {
    _testMaximumTrackImage(animatableSlider)
  }

  func testMaximumTrackHighlightedImage() {
    _testMaximumTrackHighlightedImage(animatableSlider)
  }

  func testMinimumTrackImage() {
    _testMinimumTrackImage(animatableSlider)
  }

  func testMinimumTrackHighlightedImage() {
    _testMinimumTrackHighlightedImage(animatableSlider)
  }

}
