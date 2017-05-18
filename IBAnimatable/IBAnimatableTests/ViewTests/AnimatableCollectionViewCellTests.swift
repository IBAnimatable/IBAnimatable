//
//  AnimatableCollectionViewCellTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableCollectionViewCellTests: XCTestCase {

  var animatableCollectionViewCell: AnimatableCollectionViewCell!

  override func setUp() {
    super.setUp()
    animatableCollectionViewCell = AnimatableCollectionViewCell()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableCollectionViewCellTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableCollectionViewCell)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableCollectionViewCell)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableCollectionViewCellTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableCollectionViewCell)
  }

  func testOpacity() {
    _testOpacity(animatableCollectionViewCell)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableCollectionViewCell)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableCollectionViewCell)
  }

}
