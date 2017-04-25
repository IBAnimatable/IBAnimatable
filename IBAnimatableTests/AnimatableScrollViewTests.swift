//
//  AnimatableScrollViewTests.swift
//  IBAnimatable
//
//  Created by Steven on 4/25/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

class AnimatableScrollViewTests: XCTestCase {
  
  var animatableScrollView = AnimatableScrollView()

  override func setUp() {
    super.setUp()
    animatableScrollView = AnimatableScrollView()
    animatableScrollView .frame = CGRect(x: 0, y: 0, width: 100, height: 50)
  }

  override func tearDown() {
    super.tearDown()
  }

  func testCornerRadius() {
    animatableScrollView.cornerRadius = 3.0
    XCTAssertEqual(animatableScrollView.cornerRadius, animatableScrollView.layer.cornerRadius)
  }

  func testCornerSides() {
    animatableScrollView.cornerRadius = 3.0
    animatableScrollView.cornerSides = .allSides
    XCTAssertEqual(animatableScrollView.cornerRadius, animatableScrollView.layer.cornerRadius)
    animatableScrollView.cornerSides = [.bottomLeft, .bottomRight, .topLeft]
    let mask = animatableScrollView.layer.mask as? CAShapeLayer
    XCTAssertEqual(mask?.frame, CGRect(origin: .zero, size: animatableScrollView.bounds.size))
    XCTAssertEqual(mask?.name, "cornerSideLayer")
    let corners: UIRectCorner = [.bottomLeft, .bottomRight, .topLeft]
    let cornerRadii = CGSize(width: animatableScrollView.cornerRadius, height: animatableScrollView.cornerRadius)
    let mockPath = UIBezierPath(roundedRect: animatableScrollView.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
    XCTAssertEqual(mask?.path, mockPath)
  }

  func test_cornerSides() {
    animatableScrollView._cornerSides = "topLeft"
    XCTAssertEqual(animatableScrollView.cornerSides, .topLeft)
    animatableScrollView._cornerSides = "topRight"
    XCTAssertEqual(animatableScrollView.cornerSides, .topRight)
    animatableScrollView._cornerSides = "bottomLeft"
    XCTAssertEqual(animatableScrollView.cornerSides, .bottomLeft)
    animatableScrollView._cornerSides = "bottomRight"
    XCTAssertEqual(animatableScrollView.cornerSides, .bottomRight)
    animatableScrollView._cornerSides = ""
    XCTAssertEqual(animatableScrollView.cornerSides, .allSides)
    animatableScrollView._cornerSides = "allSides"
    XCTAssertEqual(animatableScrollView.cornerSides, .allSides)
  }

}
