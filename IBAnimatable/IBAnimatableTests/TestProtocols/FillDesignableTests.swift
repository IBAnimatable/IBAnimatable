//
//  FillDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

protocol FillDesignableTests: class {

  associatedtype Element

  var element: Element { get set }

  func testFillColor()
  func testOpacity()
  func testPredefinedColor()
  func test_predefinedColor()

}

// MARK: - Universal Tests

extension FillDesignableTests where Element: StringFillDesignable {

  func _test_predefinedColor() {
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

// MARK: - UIView Tests

extension FillDesignableTests where Element: UIView, Element: FillDesignable {

  func _testFillColor() {
    element.fillColor = .red
    XCTAssertEqual(element.backgroundColor, .red)
  }

  func _testOpacity() {
    element.opacity = 0.5
    XCTAssertEqual(element.opacity, element.alpha)
    XCTAssertFalse(element.isOpaque)
    element.opacity = 1.0
    XCTAssertEqual(element.opacity, element.alpha)
    XCTAssertTrue(element.isOpaque)
  }

  func _testPredefinedColor() {
    element.predefinedColor = .flatGreenSea
    XCTAssertEqual(element.backgroundColor, ColorType.flatGreenSea.color)
  }

}

// MARK: - UICollectionViewCell Tests

extension FillDesignableTests where Element: UICollectionViewCell, Element: FillDesignable {

  func _testFillColor() {
    element.fillColor = .red
    XCTAssertEqual(element.backgroundColor, .red)
    XCTAssertEqual(element.contentView.backgroundColor, .red)
  }

  func _testOpacity() {
    element.opacity = 0.5
    XCTAssertEqual(element.opacity, element.alpha)
    XCTAssertFalse(element.isOpaque)
    element.opacity = 1.0
    XCTAssertEqual(element.opacity, element.alpha)
    XCTAssertTrue(element.isOpaque)
  }

  func _testPredefinedColor() {
    element.predefinedColor = .flatClouds
    XCTAssertEqual(element.backgroundColor, ColorType.flatClouds.color)
    XCTAssertEqual(element.contentView.backgroundColor, ColorType.flatClouds.color)
  }

}
