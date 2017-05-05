//
//  ShadowDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven Deutsch on 5/5/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class ShadowDesignableTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testShadowColor() {
    helper_testShadowColor(element: AnimatableView())
    helper_testShadowColor(element: AnimatableScrollView())
    helper_testShadowColor(element: AnimatableImageView())
    helper_testShadowColor(element: AnimatableCheckBox())
    helper_testShadowColor(element: AnimatableButton())
    helper_testShadowColor(element: AnimatableCollectionViewCell())
    helper_testShadowColor(element: AnimatableTextField())
    helper_testShadowColor(element: AnimatableSlider())
    helper_testShadowColor(element: AnimatableStackView())
  }
  
  private func helper_testShadowColor(element: MockShadowDesignable) {
    element.layer.masksToBounds = true
    element.shadowColor = .green
    XCTAssertEqual(element.layer.shadowColor, UIColor.green.cgColor)
    XCTAssertFalse(element.layer.masksToBounds)
  }
  
  func testShadowRadius() {
    helper_testShadowRadius(element: AnimatableView())
    helper_testShadowRadius(element: AnimatableScrollView())
    helper_testShadowRadius(element: AnimatableImageView())
    helper_testShadowRadius(element: AnimatableCheckBox())
    helper_testShadowRadius(element: AnimatableButton())
    helper_testShadowRadius(element: AnimatableCollectionViewCell())
    helper_testShadowRadius(element: AnimatableTextField())
    helper_testShadowRadius(element: AnimatableSlider())
    helper_testShadowRadius(element: AnimatableStackView())
  }
  
  private func helper_testShadowRadius(element: MockShadowDesignable) {
    element.layer.masksToBounds = true
    element.shadowRadius = 3.0
    XCTAssertEqual(element.layer.shadowRadius, 3.0)
    XCTAssertFalse(element.layer.masksToBounds)
  }
  
  func testShadowOpacity() {
    helper_testShadowOpacity(element: AnimatableView())
    helper_testShadowOpacity(element: AnimatableScrollView())
    helper_testShadowOpacity(element: AnimatableImageView())
    helper_testShadowOpacity(element: AnimatableCheckBox())
    helper_testShadowOpacity(element: AnimatableButton())
    helper_testShadowOpacity(element: AnimatableCollectionViewCell())
    helper_testShadowOpacity(element: AnimatableTextField())
    helper_testShadowOpacity(element: AnimatableStackView())
    helper_testShadowOpacity(element: AnimatableSlider())
  }
  
  private func helper_testShadowOpacity(element: MockShadowDesignable) {
    element.layer.masksToBounds = true
    element.shadowOpacity = 0.7
    XCTAssertEqual(element.layer.shadowOpacity, 0.7)
    XCTAssertFalse(element.layer.masksToBounds)
  }
  
  func testShadowOffset() {
    helper_testShadowOffset(element: AnimatableView())
    helper_testShadowOffset(element: AnimatableScrollView())
    helper_testShadowOffset(element: AnimatableImageView())
    helper_testShadowOffset(element: AnimatableCheckBox())
    helper_testShadowOffset(element: AnimatableButton())
    helper_testShadowOffset(element: AnimatableCollectionViewCell())
    helper_testShadowOpacity(element: AnimatableTextField())
    helper_testShadowOffset(element: AnimatableStackView())
    helper_testShadowOffset(element: AnimatableSlider())
  }
  
  private func helper_testShadowOffset(element: MockShadowDesignable) {
    element.layer.masksToBounds = true
    element.shadowOffset = CGPoint(x: 3.0, y: 11.0)
    XCTAssertEqual(element.layer.shadowOffset.width, 3.0)
    XCTAssertEqual(element.layer.shadowOffset.height, 11.0)
    XCTAssertFalse(element.layer.masksToBounds)
  }
  
}

// MARK - MockShadowDesignable

fileprivate protocol MockShadowDesignable: class, ShadowDesignable {
  var layer: CALayer { get }
}

// MARK: - Classes with ShadowDesignable conformance

extension AnimatableView: MockShadowDesignable {}
extension AnimatableScrollView: MockShadowDesignable {}
extension AnimatableButton: MockShadowDesignable {}
extension AnimatableCheckBox: MockShadowDesignable {}
extension AnimatableImageView: MockShadowDesignable {}
extension AnimatableStackView: MockShadowDesignable {}
extension AnimatableCollectionViewCell: MockShadowDesignable {}
extension AnimatableTextField: MockShadowDesignable {}
extension AnimatableSlider: MockShadowDesignable {}




