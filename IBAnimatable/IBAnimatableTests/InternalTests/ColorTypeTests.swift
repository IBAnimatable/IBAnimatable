//
//  ColorTypeTests.swift
//  IBAnimatable
//
//  Created by Steven on 4/26/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class ColorTypeTests: XCTestCase {

  func testColor() {
    XCTAssertEqual(#colorLiteral(red: 0.180392156862745, green: 0.8, blue: 0.443137254901961, alpha: 1.0), ColorType.flatEmerland.color)
    XCTAssertEqual(#colorLiteral(red: 0.752941176470588, green: 0.223529411764706, blue: 0.168627450980392, alpha: 1.0), ColorType.flatPomegranate.color)
    XCTAssertEqual(#colorLiteral(red: 0.203921568627451, green: 0.286274509803922, blue: 0.368627450980392, alpha: 1.0), ColorType.flatWetAsphalt.color)
    XCTAssertEqual(#colorLiteral(red: 0.101960784313725, green: 0.737254901960784, blue: 0.611764705882353, alpha: 1.0), ColorType.flatTurquoise.color)
    XCTAssertEqual(#colorLiteral(red: 0.584313725490196, green: 0.647058823529412, blue: 0.650980392156863, alpha: 1.0), ColorType.flatConcrete.color)
    XCTAssertEqual(#colorLiteral(red: 0.952941176470588, green: 0.611764705882353, blue: 0.0705882352941176, alpha: 1.0), ColorType.flatOrange.color)
    XCTAssertEqual(#colorLiteral(red: 0.498039215686275, green: 0.549019607843137, blue: 0.552941176470588, alpha: 1.0), ColorType.flatAsbestos.color)
    XCTAssertEqual(#colorLiteral(red: 0.203921568627451, green: 0.596078431372549, blue: 0.858823529411765, alpha: 1.0), ColorType.flatPeterRiver.color)
    XCTAssertEqual(#colorLiteral(red: 0.741176470588235, green: 0.764705882352941, blue: 0.780392156862745, alpha: 1.0), ColorType.flatSilver.color)
    XCTAssertEqual(#colorLiteral(red: 0.945098039215686, green: 0.768627450980392, blue: 0.0588235294117647, alpha: 1.0), ColorType.flatSunFlower.color)
    XCTAssertEqual(#colorLiteral(red: 0.607843137254902, green: 0.349019607843137, blue: 0.713725490196078, alpha: 1.0), ColorType.flatAmethyst.color)
    XCTAssertEqual(#colorLiteral(red: 0.905882352941176, green: 0.298039215686275, blue: 0.235294117647059, alpha: 1.0), ColorType.flatAlizarin.color)
    XCTAssertEqual(#colorLiteral(red: 0.0862745098039216, green: 0.627450980392157, blue: 0.52156862745098, alpha: 1.0), ColorType.flatGreenSea.color)
    XCTAssertEqual(#colorLiteral(red: 0.16078431372549, green: 0.501960784313725, blue: 0.725490196078431, alpha: 1.0), ColorType.flatBelizeHole.color)
    XCTAssertEqual(#colorLiteral(red: 0.152941176470588, green: 0.682352941176471, blue: 0.376470588235294, alpha: 1.0), ColorType.flatNephritis.color)
    XCTAssertEqual(#colorLiteral(red: 0.172549019607843, green: 0.243137254901961, blue: 0.313725490196078, alpha: 1.0), ColorType.flatMidnightBlue.color)
    XCTAssertEqual(#colorLiteral(red: 0.925490196078431, green: 0.941176470588235, blue: 0.945098039215686, alpha: 1.0), ColorType.flatClouds.color)
    XCTAssertEqual(#colorLiteral(red: 0.556862745098039, green: 0.266666666666667, blue: 0.67843137254902, alpha: 1.0), ColorType.flatWisteria.color)
    XCTAssertEqual(#colorLiteral(red: 0.901960784313726, green: 0.494117647058824, blue: 0.133333333333333, alpha: 1.0), ColorType.flatCarrot.color)
    XCTAssertEqual(#colorLiteral(red: 0.827450980392157, green: 0.329411764705882, blue: 0.0, alpha: 1.0), ColorType.flatPumpkin.color)
  }

  func testHexStringToColor() {
    // without alpha
    XCTAssertEqual(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), UIColor(hexString: "FFFFFF"))
    XCTAssertEqual(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), UIColor(hexString: "000000"))
    XCTAssertEqual(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), UIColor(hexString: "FF0000"))
    XCTAssertEqual(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1), UIColor(hexString: "00FF00"))
    XCTAssertEqual(#colorLiteral(red: 0, green: 0, blue: 1, alpha: 1), UIColor(hexString: "0000FF"))
    XCTAssertEqual(#colorLiteral(red: 1, green: 0, blue: 1, alpha: 1), UIColor(hexString: "FF00FF"))
    XCTAssertEqual(#colorLiteral(red: 0, green: 1, blue: 1, alpha: 1), UIColor(hexString: "00FFFF"))
    XCTAssertEqual(#colorLiteral(red: 1, green: 1, blue: 0, alpha: 1), UIColor(hexString: "FFFF00"))

    // with alpha
    XCTAssertEqual(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0), UIColor(hexString: "00FFFFFF"))
    XCTAssertEqual(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), UIColor(hexString: "00000000"))
    XCTAssertEqual(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), UIColor(hexString: "FFFFFFFF"))

    // could not test with standards uicolor equals.
    // XCTAssertEqual(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5), UIColor(hexString: "80FFFFFF"))
    // XCTAssertEqual(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8), UIColor(hexString: "CC000000"))
    // XCTAssertEqual(#colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1), UIColor(hexString: "E67E22"))
    // XCTAssertEqual(#colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1), UIColor(hexString: "E74C3C"))

  }

}
