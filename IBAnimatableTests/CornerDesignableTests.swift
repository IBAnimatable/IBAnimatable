//
//  CornerDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 4/24/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

class CornerDesignableTests: XCTestCase {

  func testCornerRadius() {
    helper_testCornerRadius_UIView(element: AnimatableView(), message: "AnimatableView failed")
    helper_testCornerRadius_UIView(element: AnimatableCheckBox(), message: "AnimatableCheckBox failed")
    helper_testCornerRadius_UICollectionViewCell(element: AnimatableCollectionViewCell(), message: "AnimatableCollectionViewCell failed")
    helper_testCornerRadius_UIView(element: AnimatableImageView(), message: "AnimatableImageView failed")
    helper_testCornerRadius_UIView(element: AnimatableLabel(), message: "AnimatableLabel failed")
    helper_testCornerRadius_UIView(element: AnimatableStackView(), message: "AnimatableStackView failed")
    helper_testCornerRadius_UIView(element: AnimatableTableViewCell(), message: "AnimatableTableViewCell failed")
    helper_testCornerRadius_UIView(element: AnimatableStackView(), message: "AnimatableStackView failed")
    helper_testCornerRadius_UIView(element: AnimatableView(), message: "AnimatableView failed")
  }

  private func helper_testCornerRadius_UIView(element: MockUIViewCornerDesignable, message: String) {
    var element = element
    element.cornerRadius = 3.0
    element.cornerSides = .allSides
    XCTAssertEqual(element.cornerRadius, element.layer.cornerRadius)
    element.cornerSides = [.bottomLeft, .bottomRight, .topLeft]
    let mask = element.layer.mask as? CAShapeLayer
    XCTAssertEqual(mask?.frame, CGRect(origin: .zero, size: element.bounds.size))
    XCTAssertEqual(mask?.name, "cornerSideLayer")
    let corners: UIRectCorner = [.bottomLeft, .bottomRight, .topLeft]
    let cornerRadii = CGSize(width: element.cornerRadius, height: element.cornerRadius)
    let mockPath = UIBezierPath(roundedRect: element.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
    XCTAssertEqual(mask?.path, mockPath)
  }

  private func helper_testCornerRadius_UICollectionViewCell(element: MockUICollectionViewCellCornerDesignable, message: String) {
    var element = element
    element.cornerRadius = -1
    XCTAssertFalse(element.contentView.layer.masksToBounds)
    element.layer.mask?.name = "cornerSideLayer"
    element.cornerRadius = 3.0
    XCTAssertNil(element.layer.mask)
    XCTAssertEqual(element.layer.cornerRadius, 0.0)
    element.cornerSides = .allSides
    XCTAssertEqual(element.contentView.layer.cornerRadius, element.cornerRadius)
    element.cornerSides = [.bottomLeft, .bottomRight, .topLeft]
    XCTAssertEqual(element.contentView.layer.cornerRadius, 0.0)
    let mask = element.contentView.layer.mask as? CAShapeLayer
    XCTAssertEqual(mask?.frame, CGRect(origin: .zero, size: element.bounds.size))
    XCTAssertEqual(mask?.name, "cornerSideLayer")
    let corners: UIRectCorner = [.bottomLeft, .bottomRight, .topLeft]
    let cornerRadii = CGSize(width: element.cornerRadius, height: element.cornerRadius)
    let mockPath = UIBezierPath(roundedRect: element.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
    XCTAssertEqual(mask?.path, mockPath)
    XCTAssertTrue(element.contentView.layer.masksToBounds)
  }

  func test_cornerSides() {
    helper_test_cornerSides(element: AnimatableButton(), message: "AnimatableButton failed")
    helper_test_cornerSides(element: AnimatableCheckBox(), message: "AnimatableCheckBox failed")
    helper_test_cornerSides(element: AnimatableCollectionViewCell(), message: "AnimatableCollectionViewCell failed")
    helper_test_cornerSides(element: AnimatableImageView(), message: "AnimatableImageView failed")
    helper_test_cornerSides(element: AnimatableLabel(), message: "AnimatableLabel failed")
    helper_test_cornerSides(element: AnimatableStackView(), message: "AnimatableStackView failed")
    helper_test_cornerSides(element: AnimatableTableViewCell(), message: "AnimatableTableViewCell failed")
    helper_test_cornerSides(element: AnimatableTextField(), message: "AnimatableTextField failed")
    helper_test_cornerSides(element: AnimatableTextView(), message: "AnimatableTextView failed")
    helper_test_cornerSides(element: AnimatableView(), message: "AnimatableView failed")
  }

  private func helper_test_cornerSides(element: MockUIViewCornerDesignable, message: String) {
    element._cornerSides = "topLeft"
    XCTAssertEqual(element.cornerSides, .topLeft, message)
    element._cornerSides = "topRight"
    XCTAssertEqual(element.cornerSides, .topRight, message)
    element._cornerSides = "bottomLeft"
    XCTAssertEqual(element.cornerSides, .bottomLeft, message)
    element._cornerSides = "bottomRight"
    XCTAssertEqual(element.cornerSides, .bottomRight, message)
    element._cornerSides = "allSides"
    XCTAssertEqual(element.cornerSides, .allSides, message)
    element._cornerSides = ""
    XCTAssertEqual(element.cornerSides, .allSides, message)
  }

}

// MARK: - MockStringCornerDesignable
fileprivate protocol MockUIViewCornerDesignable: class, CornerDesignable {

  var _cornerSides: String? { get set }
  var layer: CALayer { get }
  var bounds: CGRect { get set }

}

// MARK: - MockUICollectionViewCellCornerDesignable
fileprivate protocol MockUICollectionViewCellCornerDesignable: class, MockUIViewCornerDesignable {

  var contentView: UIView { get }

}

// MARK: - Classes with CornerDesignable conformance
extension AnimatableButton: MockUIViewCornerDesignable {}
extension AnimatableCheckBox: MockUIViewCornerDesignable {}
extension AnimatableCollectionViewCell: MockUICollectionViewCellCornerDesignable {}
extension AnimatableImageView: MockUIViewCornerDesignable {}
extension AnimatableLabel: MockUIViewCornerDesignable {}
extension AnimatableScrollView: MockUIViewCornerDesignable {}
extension AnimatableStackView: MockUIViewCornerDesignable {}
extension AnimatableTableViewCell: MockUIViewCornerDesignable {}
extension AnimatableTextField: MockUIViewCornerDesignable {}
extension AnimatableTextView: MockUIViewCornerDesignable {}
extension AnimatableView: MockUIViewCornerDesignable {}
