//
//  SliderImagesDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/15/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

protocol SliderImagesDesignableTests: class {

  associatedtype Element

  var element: Element { get set }

  func testThumbImage()
  func testThumbHighlightedImage()
  func testMaximumTrackImage()
  func testMaximumTrackHighlightedImage()
  func testMinimumTrackImage()
  func testMinimumTrackHighlightedImage()

}

// MARK: - UISlider Tests

extension SliderImagesDesignableTests where Element: UISlider, Element: SliderImagesDesignable {

  func _testThumbImage() {
    let normalImage = UIImage()
    element.thumbImage = normalImage
    XCTAssertEqual(element.thumbImage(for: .normal), normalImage)
  }

  func _testThumbHighlightedImage() {
    let normalImage = UIImage()
    let highlightedImage = UIImage()
    element.thumbImage = normalImage
    element.thumbHighlightedImage = nil
    XCTAssertEqual(element.thumbImage(for: .normal), normalImage)
    XCTAssertEqual(element.thumbImage(for: .highlighted), normalImage)
    element.thumbHighlightedImage = highlightedImage
    XCTAssertEqual(element.thumbImage(for: .highlighted), highlightedImage)
  }

  func _testMaximumTrackImage() {
    let normalImage = UIImage()
    element.maximumTrackImage = normalImage
    XCTAssertEqual(element.maximumTrackImage(for: .normal), normalImage)
  }

  func _testMaximumTrackHighlightedImage() {
    let normalImage = UIImage()
    let highlightedImage = UIImage()
    element.maximumTrackImage = normalImage
    element.maximumTrackHighlightedImage = nil
    XCTAssertEqual(element.maximumTrackImage(for: .normal), normalImage)
    XCTAssertEqual(element.maximumTrackImage(for: .highlighted), normalImage)
    element.maximumTrackHighlightedImage = highlightedImage
    XCTAssertEqual(element.maximumTrackImage(for: .highlighted), highlightedImage)
  }

  func _testMinimumTrackImage() {
    let normalImage = UIImage()
    element.minimumTrackImage = normalImage
    XCTAssertEqual(element.minimumTrackImage(for: .normal), normalImage)
  }

  func _testMinimumTrackHighlightedImage() {
    let normalImage = UIImage()
    let highlightedImage = UIImage()
    element.minimumTrackImage = normalImage
    element.minimumTrackHighlightedImage = nil
    XCTAssertEqual(element.minimumTrackImage(for: .normal), normalImage)
    XCTAssertEqual(element.minimumTrackImage(for: .highlighted), normalImage)
    element.minimumTrackHighlightedImage = highlightedImage
    XCTAssertEqual(element.minimumTrackImage(for: .highlighted), highlightedImage)
  }

}
