//
//  AnimatableTypeTests.swift
//  IBAnimatableTests
//
//  Created by phimage on 06/05/2019.
//  Copyright © 2019 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable
final class AnimatableTypeTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testAnimatableType() {
    var types: [String: AnimationType] = [
      "slide": .slide(way: .in, direction: .left),
      "slide(in,left)": .slide(way: .in, direction: .left),
      "slide(out,right)": .slide(way: .out, direction: .right),
      "shake": .shake(repeatCount: 1),
      "shake(10)": .shake(repeatCount: 10)]

    // compound
    types["compound(shake,slide)"] = .compound(animations: [types["shake"]!, types["slide"]!], run: .parallel)
    types["compound(shake,slide,sequential)"] = .compound(animations: [types["shake"]!, types["slide"]!], run: .sequential)

    types["compound(compound(shake(10), slide), shake(10))"] = .compound(
      animations: [.compound(animations: [types["shake(10)"]!, types["slide"]!], run: .parallel), types["shake(10)"]!],
      run: .parallel)

    /// with array (default run mode sequential)
    types["[shake,slide]"] = .compound(animations: [types["shake"]!, types["slide"]!], run: .sequential)
    types["[shake,slide,parallel]"] = .compound(animations: [types["shake"]!, types["slide"]!], run: .parallel)
    types["[shake(10), slide]"] = .compound(animations: [types["shake(10)"]!, types["slide"]!], run: .sequential)

    types["[[shake(10), slide]]"] = .compound(
      animations: [.compound(animations: [types["shake(10)"]!, types["slide"]!], run: .sequential)],
      run: .sequential)

    types["[[shake(10), slide], shake(10)]"] = .compound(
      animations: [.compound(animations: [types["shake(10)"]!, types["slide"]!], run: .sequential), types["shake(10)"]!],
      run: .sequential)

    /// with operator (default run mode parallel)
    types["shake+slide"] = .compound(animations: [types["shake"]!, types["slide"]!], run: .parallel)
    types["shake(10)+slide"] = .compound(animations: [types["shake(10)"]!, types["slide"]!], run: .parallel)
    types["shake+slide+pop"] = .compound(animations: [types["shake+slide"]!, .pop(repeatCount: 1)], run: .parallel)
    // types["shake+slide+pop"] = .compound(animations: [types["shake"]!, types["slide"]!, .pop(repeatCount: 1)], run: .parallel) // if implement flatenize

    /// with some mix
    types["[shake,shake+slide]"] = .compound(animations: [types["shake"]!, types["shake+slide"]!], run: .sequential)
    types["[shake(10),shake(10)+slide]"] = .compound(animations: [types["shake(10)"]!, types["shake(10)+slide"]!], run: .sequential)

    for (string, expected) in types {
      let animation = AnimationType(string: string)
      XCTAssertEqual("\(animation)", "\(expected)", string) // test string if `AnimationType` not equatable
    }
  }

}
