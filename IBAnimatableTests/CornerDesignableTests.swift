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

  // MARK: - testCornerRadius

  func testCornerRadius() {
    helper_testCornerRadius_UIView(element: AnimatableView())
    helper_testCornerRadius_UIView(element: AnimatableCheckBox())
    helper_testCornerRadius_UICollectionViewCell(element: AnimatableCollectionViewCell())
    helper_testCornerRadius_UIView(element: AnimatableImageView())
    helper_testCornerRadius_UIView(element: AnimatableLabel())
    helper_testCornerRadius_UIView(element: AnimatableStackView())
    helper_testCornerRadius_UIView(element: AnimatableTableViewCell())
    helper_testCornerRadius_UIView(element: AnimatableStackView())
    helper_testCornerRadius_UIView(element: AnimatableView())
  }

  private func helper_testCornerRadius_UIView(element: MockUIViewCornerDesignable) {
    var element = element
    element.cornerRadius = 3.0
    element.cornerSides = .allSides
    XCTAssertEqual(element.cornerRadius, element.layer.cornerRadius)
    element.cornerSides = [.bottomLeft, .bottomRight, .topLeft]
    let mask = element.layer.mask as? CAShapeLayer
    XCTAssertEqual(mask?.frame, CGRect(origin: .zero, size: element.bounds.size))
    XCTAssertEqual(mask?.name, "cornerSideLayer")
    let mockPath = cgPath(for: element, withCorners: [.bottomLeft, .bottomRight, .topLeft])
    XCTAssertEqual(mask?.path, mockPath)
  }

  private func helper_testCornerRadius_UICollectionViewCell(element: MockUICollectionViewCellCornerDesignable) {
    var element = element
    element.cornerRadius = -1
    XCTAssertFalse(element.contentView.layer.masksToBounds)
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
    let mockPath = cgPath(for: element, withCorners: [.bottomLeft, .bottomRight, .topLeft])
    XCTAssertEqual(mask?.path, mockPath)
    XCTAssertTrue(element.contentView.layer.masksToBounds)
  }

  private func cgPath(for element: MockUIViewCornerDesignable, withCorners corners: UIRectCorner) -> CGPath {
    let cornerRadii = CGSize(width: element.cornerRadius, height: element.cornerRadius)
    return UIBezierPath(roundedRect: element.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
  }

  // MARK: test_cornerSides

  func test_cornerSides() {
    helper_test_cornerSides(element: AnimatableButton())
    helper_test_cornerSides(element: AnimatableCheckBox())
    helper_test_cornerSides(element: AnimatableCollectionViewCell())
    helper_test_cornerSides(element: AnimatableImageView())
    helper_test_cornerSides(element: AnimatableLabel())
    helper_test_cornerSides(element: AnimatableStackView())
    helper_test_cornerSides(element: AnimatableTableViewCell())
    helper_test_cornerSides(element: AnimatableTextField())
    helper_test_cornerSides(element: AnimatableTextView())
    helper_test_cornerSides(element: AnimatableView())
  }

  private func helper_test_cornerSides(element: MockUIViewCornerDesignable) {
    element._cornerSides = "topLeft"
    XCTAssertEqual(element.cornerSides, .topLeft)
    element._cornerSides = "topRight"
    XCTAssertEqual(element.cornerSides, .topRight)
    element._cornerSides = "bottomLeft"
    XCTAssertEqual(element.cornerSides, .bottomLeft)
    element._cornerSides = "bottomRight"
    XCTAssertEqual(element.cornerSides, .bottomRight)
    element._cornerSides = "allSides"
    XCTAssertEqual(element.cornerSides, .allSides)
    element._cornerSides = ""
    XCTAssertEqual(element.cornerSides, .allSides)
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
