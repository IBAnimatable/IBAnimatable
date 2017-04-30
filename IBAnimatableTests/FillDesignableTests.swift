//
//  FillDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 4/25/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

class FillDesignableTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - testFillColor

  func testFillColor() {
    helper_testFillColor_UIView(element: AnimatableView())
    helper_testFillColor_UIView(element: AnimatableScrollView())
    helper_testFillColor_UIView(element: AnimatableButton())
    helper_testFillColor_UIView(element: AnimatableCheckBox())
    helper_testFillColor_UIView(element: AnimatableImageView())
    //helper_testFillColor_UIView(element: AnimatableStackView()) // broken see #461
    helper_testFillColor_UIView(element: AnimatableTableView())
    helper_testFillColor_UIView(element: AnimatableTextField())
    helper_testFillColor_UIView(element: AnimatableTextView())
    helper_testFillColor_Cell(element: AnimatableTableViewCell())
    helper_testFillColor_Cell(element: AnimatableCollectionViewCell())
  }

  private func helper_testFillColor_UIView(element: MockUIViewFillDesignable) {
    element.fillColor = .red
    XCTAssertEqual(element.backgroundColor, .red)
  }

  private func helper_testFillColor_Cell(element: MockCellFillDesignable) {
    element.fillColor = .red
    XCTAssertEqual(element.backgroundColor, .red)
    XCTAssertEqual(element.contentView.backgroundColor, .red)
  }

  // MARK: - testOpacity

  func testOpacity() {
    helper_testOpacity(element: AnimatableView())
    helper_testOpacity(element: AnimatableScrollView())
    helper_testOpacity(element: AnimatableButton())
    helper_testOpacity(element: AnimatableCheckBox())
    helper_testOpacity(element: AnimatableImageView())
    //helper_testOpacity(element: AnimatableStackView()) // broken see #461
    helper_testOpacity(element: AnimatableTableView())
    helper_testOpacity(element: AnimatableTextField())
    helper_testOpacity(element: AnimatableTextView())
    helper_testOpacity(element: AnimatableTableViewCell())
    helper_testOpacity(element: AnimatableCollectionViewCell())
  }

  private func helper_testOpacity(element: MockUIViewFillDesignable) {
    element.opacity = 0.5
    XCTAssertEqual(element.opacity, element.alpha)
    XCTAssertFalse(element.isOpaque)
    element.opacity = 1.0
    XCTAssertEqual(element.opacity, element.alpha)
    XCTAssertTrue(element.isOpaque)
  }

  // MARK: - testPredefinedColor

  func testPredefinedColor() {
    helper_testPredefinedColor_UIView(element: AnimatableView())
    helper_testPredefinedColor_UIView(element: AnimatableScrollView())
    helper_testPredefinedColor_UIView(element: AnimatableButton())
    helper_testPredefinedColor_UIView(element: AnimatableCheckBox())
    helper_testPredefinedColor_UIView(element: AnimatableImageView())
    //helper_testPredefinedColor_UIView(element: AnimatableStackView()) // broken see #461
    helper_testPredefinedColor_UIView(element: AnimatableTableView())
    helper_testPredefinedColor_UIView(element: AnimatableTextField())
    helper_testPredefinedColor_UIView(element: AnimatableTextView())
    helper_testPredefinedColor_CellView(element: AnimatableTableViewCell())
    helper_testPredefinedColor_CellView(element: AnimatableCollectionViewCell())
  }

  private func helper_testPredefinedColor_UIView(element: MockUIViewFillDesignable) {
    element.predefinedColor = .flatGreenSea
    XCTAssertEqual(element.backgroundColor, ColorType.flatGreenSea.color)
  }

  private func helper_testPredefinedColor_CellView(element: MockCellFillDesignable) {
    element.predefinedColor = .flatClouds
    XCTAssertEqual(element.backgroundColor, ColorType.flatClouds.color)
    XCTAssertEqual(element.contentView.backgroundColor, ColorType.flatClouds.color)
  }

  // MARK: - test_predefinedColor

  func test_predefinedColor() {
    helper_test_predefinedColor(element: AnimatableView())
    helper_test_predefinedColor(element: AnimatableScrollView())
    helper_test_predefinedColor(element: AnimatableButton())
    helper_test_predefinedColor(element: AnimatableCheckBox())
    helper_test_predefinedColor(element: AnimatableImageView())
    helper_test_predefinedColor(element: AnimatableStackView())
    helper_test_predefinedColor(element: AnimatableTableView())
    helper_test_predefinedColor(element: AnimatableTextField())
    helper_test_predefinedColor(element: AnimatableTextView())
    helper_test_predefinedColor(element: AnimatableTableViewCell())
    helper_test_predefinedColor(element: AnimatableCollectionViewCell())
  }

  private func helper_test_predefinedColor(element: MockUIViewFillDesignable) {
    element._predefinedColor = "flatEmerland"
    XCTAssertEqual(element.predefinedColor, .flatEmerland)
    element._predefinedColor = "flatPomegranate"
    XCTAssertEqual(element.predefinedColor, .flatPomegranate)
    element._predefinedColor = "flatWetAsphalt"
    XCTAssertEqual(element.predefinedColor, .flatWetAsphalt)
    element._predefinedColor = "flatTurquoise"
    XCTAssertEqual(element.predefinedColor, .flatTurquoise)
    element._predefinedColor = "flatConcrete"
    XCTAssertEqual(element.predefinedColor, .flatConcrete)
    element._predefinedColor = "flatOrange"
    XCTAssertEqual(element.predefinedColor, .flatOrange)
    element._predefinedColor = "flatAsbestos"
    XCTAssertEqual(element.predefinedColor, .flatAsbestos)
    element._predefinedColor = "flatPeterRiver"
    XCTAssertEqual(element.predefinedColor, .flatPeterRiver)
    element._predefinedColor =  "flatSilver"
    XCTAssertEqual(element.predefinedColor, .flatSilver)
    element._predefinedColor = "flatSunFlower"
    XCTAssertEqual(element.predefinedColor, .flatSunFlower)
    element._predefinedColor =  "flatAmethyst"
    XCTAssertEqual(element.predefinedColor, .flatAmethyst)
    element._predefinedColor =  "flatAlizarin"
    XCTAssertEqual(element.predefinedColor, .flatAlizarin)
    element._predefinedColor =  "flatGreenSea"
    XCTAssertEqual(element.predefinedColor, .flatGreenSea)
    element._predefinedColor =  "flatBelizeHole"
    XCTAssertEqual(element.predefinedColor, .flatBelizeHole)
    element._predefinedColor =  "flatNephritis"
    XCTAssertEqual(element.predefinedColor, .flatNephritis)
    element._predefinedColor =  "flatMidnightBlue"
    XCTAssertEqual(element.predefinedColor, .flatMidnightBlue)
    element._predefinedColor =  "flatClouds"
    XCTAssertEqual(element.predefinedColor, .flatClouds)
    element._predefinedColor =  "flatWisteria"
    XCTAssertEqual(element.predefinedColor, .flatWisteria)
    element._predefinedColor =  "flatCarrot"
    XCTAssertEqual(element.predefinedColor, .flatCarrot)
    element._predefinedColor =  "flatPumpkin"
    XCTAssertEqual(element.predefinedColor, .flatPumpkin)
  }
}

// MARK: - MockUIViewFillDesignable

fileprivate protocol MockUIViewFillDesignable: class, FillDesignable {

  var _predefinedColor: String? { get set }
  var backgroundColor: UIColor? { get set }
  var alpha: CGFloat { get set }
  var isOpaque: Bool { get set }

}

// MARK: - MockCellFillDesignable

fileprivate protocol MockCellFillDesignable: class, MockUIViewFillDesignable, FillDesignable {

  var contentView: UIView { get }

}

// MARK: - Classes with FillDesignable conformance

extension AnimatableView: MockUIViewFillDesignable {}
extension AnimatableScrollView: MockUIViewFillDesignable {}
extension AnimatableButton: MockUIViewFillDesignable {}
extension AnimatableCheckBox: MockUIViewFillDesignable {}
extension AnimatableImageView: MockUIViewFillDesignable {}
extension AnimatableStackView: MockUIViewFillDesignable {}
extension AnimatableTableView: MockUIViewFillDesignable {}
extension AnimatableTableViewCell: MockCellFillDesignable {}
extension AnimatableCollectionViewCell: MockCellFillDesignable {}
extension AnimatableTextView: MockUIViewFillDesignable {}
extension AnimatableTextField: MockUIViewFillDesignable {}
