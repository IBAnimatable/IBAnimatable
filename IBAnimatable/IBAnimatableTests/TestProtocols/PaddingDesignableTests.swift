//
//  PaddingDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/15/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

protocol PaddingDesignableTests: class {

  associatedtype Element

  var element: Element { get set }

  func testPaddingLeft()
  func testPaddingRight()
  func testPaddingSide()

}

// MARK: - UITextField Tests

extension PaddingDesignableTests where Element: UITextField, Element: PaddingDesignable {

  func _testPaddingLeft() {
    element.paddingLeft = 10.0
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: 1))
    XCTAssertEqual(element.leftView?.frame, paddingView.frame)
    XCTAssertEqual(element.leftViewMode, .always)
  }

  func _testPaddingRight() {
    element.paddingRight = 15.0
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15.0, height: 1))
    XCTAssertEqual(element.rightView?.frame, paddingView.frame)
    XCTAssertEqual(element.rightViewMode, .always)
  }

  func _testPaddingSide() {
    element.paddingSide = 20.0
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20.0, height: 1))
    XCTAssertEqual(element.rightView?.frame, paddingView.frame)
    XCTAssertEqual(element.rightViewMode, .always)
    XCTAssertEqual(element.leftView?.frame, paddingView.frame)
    XCTAssertEqual(element.leftViewMode, .always)
  }

}
