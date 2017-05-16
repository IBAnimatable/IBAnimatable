//
//  SliderImagesDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/15/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

protocol SliderImagesDesignableTests {

  func testThumbImage()
  func testThumbHighlightedImage()
  func testMaximumTrackImage()
  func testMaximumTrackHighlightedImage()
  func testMinimumTrackImage()
  func testMinimumTrackHighlightedImage()

}

extension SliderImagesDesignableTests {

  func _testThumbImage<E: UISlider>(_ element: E) where E: SliderImagesDesignable {
    let normalImage = UIImage()
    element.thumbImage = normalImage
    XCTAssertEqual(element.thumbImage(for: .normal), normalImage)
  }

  func _testThumbHighlightedImage<E: UISlider>(_ element: E) where E: SliderImagesDesignable {
    let normalImage = UIImage()
    let highlightedImage = UIImage()
    element.thumbImage = normalImage
    element.thumbHighlightedImage = nil
    XCTAssertEqual(element.thumbImage(for: .normal), normalImage)
    XCTAssertEqual(element.thumbImage(for: .highlighted), normalImage)
    element.thumbHighlightedImage = highlightedImage
    XCTAssertEqual(element.thumbImage(for: .highlighted), highlightedImage)
  }

  func _testMaximumTrackImage<E: UISlider>(_ element: E) where E: SliderImagesDesignable {
    let normalImage = UIImage()
    element.maximumTrackImage = normalImage
    XCTAssertEqual(element.maximumTrackImage(for: .normal), normalImage)
  }

  func _testMaximumTrackHighlightedImage<E: UISlider>(_ element: E) where E: SliderImagesDesignable {
    let normalImage = UIImage()
    let highlightedImage = UIImage()
    element.maximumTrackImage = normalImage
    element.maximumTrackHighlightedImage = nil
    XCTAssertEqual(element.maximumTrackImage(for: .normal), normalImage)
    XCTAssertEqual(element.maximumTrackImage(for: .highlighted), normalImage)
    element.maximumTrackHighlightedImage = highlightedImage
    XCTAssertEqual(element.maximumTrackImage(for: .highlighted), highlightedImage)
  }

  func _testMinimumTrackImage<E: UISlider>(_ element: E) where E: SliderImagesDesignable {
    let normalImage = UIImage()
    element.minimumTrackImage = normalImage
    XCTAssertEqual(element.minimumTrackImage(for: .normal), normalImage)
  }

  func _testMinimumTrackHighlightedImage<E: UISlider>(_ element: E) where E: SliderImagesDesignable {
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
