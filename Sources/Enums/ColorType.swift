//
//  Created by Tom Baranes on 13/02/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public enum ColorType: String, IBEnum {
  case flatEmerland
  case flatPomegranate
  case flatWetAsphalt
  case flatTurquoise
  case flatConcrete
  case flatOrange
  case flatAsbestos
  case flatPeterRiver
  case flatSilver
  case flatSunFlower
  case flatAmethyst
  case flatAlizarin
  case flatGreenSea
  case flatBelizeHole
  case flatNephritis
  case flatMidnightBlue
  case flatClouds
  case flatWisteria
  case flatCarrot
  case flatPumpkin
}

#if swift(>=4.2)
extension ColorType: CaseIterable {}
#endif

extension ColorType {
  public var color: UIColor {
    switch self {
    case .flatBelizeHole:
      return #colorLiteral(red: 0.16078431372549, green: 0.501960784313725, blue: 0.725490196078431, alpha: 1.0)
    case .flatAlizarin:
      return #colorLiteral(red: 0.905882352941176, green: 0.298039215686275, blue: 0.235294117647059, alpha: 1.0)
    case .flatEmerland:
      return #colorLiteral(red: 0.180392156862745, green: 0.8, blue: 0.443137254901961, alpha: 1.0)
    case .flatMidnightBlue:
      return #colorLiteral(red: 0.172549019607843, green: 0.243137254901961, blue: 0.313725490196078, alpha: 1.0)
    case .flatPumpkin:
      return #colorLiteral(red: 0.827450980392157, green: 0.329411764705882, blue: 0.0, alpha: 1.0)
    case .flatAmethyst:
      return #colorLiteral(red: 0.607843137254902, green: 0.349019607843137, blue: 0.713725490196078, alpha: 1.0)
    case .flatOrange:
      return #colorLiteral(red: 0.952941176470588, green: 0.611764705882353, blue: 0.0705882352941176, alpha: 1.0)
    case .flatNephritis:
      return #colorLiteral(red: 0.152941176470588, green: 0.682352941176471, blue: 0.376470588235294, alpha: 1.0)
    case .flatGreenSea:
      return #colorLiteral(red: 0.0862745098039216, green: 0.627450980392157, blue: 0.52156862745098, alpha: 1.0)
    case .flatTurquoise:
      return #colorLiteral(red: 0.101960784313725, green: 0.737254901960784, blue: 0.611764705882353, alpha: 1.0)
    case .flatSunFlower:
      return #colorLiteral(red: 0.945098039215686, green: 0.768627450980392, blue: 0.0588235294117647, alpha: 1.0)
    case .flatWetAsphalt:
      return #colorLiteral(red: 0.203921568627451, green: 0.286274509803922, blue: 0.368627450980392, alpha: 1.0)
    case .flatPeterRiver:
      return #colorLiteral(red: 0.203921568627451, green: 0.596078431372549, blue: 0.858823529411765, alpha: 1.0)
    case .flatWisteria:
      return #colorLiteral(red: 0.556862745098039, green: 0.266666666666667, blue: 0.67843137254902, alpha: 1.0)
    case .flatClouds:
      return #colorLiteral(red: 0.925490196078431, green: 0.941176470588235, blue: 0.945098039215686, alpha: 1.0)
    case .flatConcrete:
      return #colorLiteral(red: 0.584313725490196, green: 0.647058823529412, blue: 0.650980392156863, alpha: 1.0)
    case .flatPomegranate:
      return #colorLiteral(red: 0.752941176470588, green: 0.223529411764706, blue: 0.168627450980392, alpha: 1.0)
    case .flatSilver:
      return #colorLiteral(red: 0.741176470588235, green: 0.764705882352941, blue: 0.780392156862745, alpha: 1.0)
    case .flatAsbestos:
      return #colorLiteral(red: 0.498039215686275, green: 0.549019607843137, blue: 0.552941176470588, alpha: 1.0)
    case .flatCarrot:
      return #colorLiteral(red: 0.901960784313726, green: 0.494117647058824, blue: 0.133333333333333, alpha: 1.0)
    }
  }
}
