//
//  RotationDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/15/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

protocol RotationDesignableTests {

  func testRotate()

}

// MARK: - UIView Tests

extension RotationDesignableTests {

  func _testRotate<E: UIView>(_ element: E) where E: RotationDesignable {
    element.rotate = -360
    XCTAssertEqual(element.transform, .identity)
    element.rotate = 360
    XCTAssertEqual(element.transform, .identity)
    element.rotate = 90
    let mockTransform = CGAffineTransform(rotationAngle: .pi * 90 / 180)
    XCTAssertEqual(element.transform, mockTransform)
  }

}
