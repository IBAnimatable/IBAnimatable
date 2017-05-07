//
//  AnimatableViewTests.swift
//  IBAnimatable
//
//  Created by Steven on 4/18/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

//swiftlint:disable type_body_length
class AnimatableViewTests: XCTestCase {

  var animatableView: AnimatableView!

  override func setUp() {
    super.setUp()
    animatableView = AnimatableView()
    animatableView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
  }

  override func tearDown() {
    super.tearDown()
  }

  func testCornerRadius() {
    animatableView.cornerRadius = 3.0
    XCTAssertEqual(animatableView.cornerRadius, animatableView.layer.cornerRadius)
  }

  func testCornerSides() {
    animatableView.cornerRadius = 3.0
    animatableView.cornerSides = .allSides
    XCTAssertEqual(animatableView.cornerRadius, animatableView.layer.cornerRadius)
    animatableView.cornerSides = [.bottomLeft, .bottomRight, .topLeft]
    let mask = animatableView.layer.mask as? CAShapeLayer
    XCTAssertEqual(mask?.frame, CGRect(origin: .zero, size: animatableView.bounds.size))
    XCTAssertEqual(mask?.name, "cornerSideLayer")
    let corners: UIRectCorner = [.bottomLeft, .bottomRight, .topLeft]
    let cornerRadii = CGSize(width: animatableView.cornerRadius, height: animatableView.cornerRadius)
    let mockPath = UIBezierPath(roundedRect: animatableView.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
    XCTAssertEqual(mask?.path, mockPath)
  }

  func test_cornerSides() {
    animatableView._cornerSides = "topLeft"
    XCTAssertEqual(animatableView.cornerSides, .topLeft)
    animatableView._cornerSides = "topRight"
    XCTAssertEqual(animatableView.cornerSides, .topRight)
    animatableView._cornerSides = "bottomLeft"
    XCTAssertEqual(animatableView.cornerSides, .bottomLeft)
    animatableView._cornerSides = "bottomRight"
    XCTAssertEqual(animatableView.cornerSides, .bottomRight)
    animatableView._cornerSides = ""
    XCTAssertEqual(animatableView.cornerSides, .allSides)
    animatableView._cornerSides = "allSides"
    XCTAssertEqual(animatableView.cornerSides, .allSides)
  }

}
