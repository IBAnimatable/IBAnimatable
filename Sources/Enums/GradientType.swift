//
//  Created by Tom Baranes on 09/02/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

// swiftlint:disable file_length
public typealias GradientColor = (start: UIColor, end: UIColor)
public enum GradientType: String, IBEnum {
  case coolBrown
  case harmonicEnergy
  case playingWithReds
  case sunnyDays
  case greenBeach
  case intuitivePurple
  case emeraldWater
  case lemonTwist
  case horizon
  case roseWater
  case frozen
  case mangoPulp
  case bloodyMary
  case aubergine
  case aquaMarine
  case sunrise
  case purpleParadise
  case seaWeed
  case pinky
  case cherry
  case mojito
  case juicyOrange
  case mirage
  case steelGray
  case kashmir
  case electricViolet
  case veniceBlue
  case boraBora
  case moss
  case shroomHaze
  case mystic
  case midnightCity
  case seaBlizz
  case opa
  case titanium
  case mantle
  case dracula
  case peach
  case moonrise
  case clouds
  case stellar
  case bourbon
  case calmDarya
  case influenza
  case shrimpy
  case army
  case miaka
  case pinotNoir
  case dayTripper
  case namn
  case blurryBeach
  case vasily
  case aLostMemory
  case petrichor
  case jonquil
  case siriusTamed
  case kyoto
  case mistyMeadow
  case aqualicious
  case moor
  case almost
  case foreverLost
  case winter
  case autumn
  case candy
  case reef
  case theStrain
  case dirtyFog
  case earthly
  case virgin
  case ash
  case shadowNight
  case cherryblossoms
  case parklife
  case danceToForget
  case starfall
  case redMist
  case tealLove
  case neonLife
  case manOfSteel
  case amethyst
  case cheerUpEmoKid
  case shore
  case facebookMessenger
  case soundcloud
  case behongo
  case servquick
  case friday
  case martini
  case metallicToad
  case betweenTheClouds
  case crazyOrangeI
  case hersheys
  case talkingToMiceElf
  case purpleBliss
  case predawn
  case endlessRiver
  case pastelOrangeAtTheSun
  case twitch
  case instagram
  case flickr
  case vine
  case turquoiseFlow
  case portrait
  case virginAmerica
  case kokoCaramel
  case freshTurboscent
  case greenToDark
  case ukraine
  case curiosityBlue
  case darkKnight
  case piglet
  case lizard
  case sagePersuasion
  case betweenNightAndDay
  case timber
  case passion
  case clearSky
  case masterCard
  case backToEarth
  case deepPurple
  case littleLeaf
  case netflix
  case lightOrange
  case greenAndBlue
  case poncho
  case backToTheFuture
  case blush
  case inbox
  case purplin
  case paleWood
  case haikus
  case pizelex
  case joomla
  case christmas
  case minnesotaVikings
  case miamiDolphins
  case forest
  case nighthawk
  case superman
  case suzy
  case darkSkies
  case deepSpace
  case decent
  case colorsOfSky
  case purpleWhite
  case ali
  case alihossein
  case shahabi
  case redOcean
  case tranquil
  case transfile
  case sylvia
  case sweetMorning
  case politics
  case brightVault
  case solidVault
  case sunset
  case grapefruitSunset
  case deepSeaSpace
  case dusk
  case minimalRed
  case royal
  case mauve
  case frost
  case lush
  case firewatch
  case sherbert
  case bloodRed
  case sunOnTheHorizon
  case iiitDelhi
}

#if swift(>=4.2)
extension GradientType: CaseIterable {}
#endif

extension GradientType {
  var colors: GradientColor {
    switch self {
    case .coolBrown:
      return (#colorLiteral(red: 0.376470588235294, green: 0.219607843137255, blue: 0.0745098039215686, alpha: 1.0), #colorLiteral(red: 0.698039215686274, green: 0.623529411764706, blue: 0.580392156862745, alpha: 1.0))
    case .harmonicEnergy:
      return (#colorLiteral(red: 0.0862745098039216, green: 0.627450980392157, blue: 0.52156862745098, alpha: 1.0), #colorLiteral(red: 0.956862745098039, green: 0.815686274509804, blue: 0.247058823529412, alpha: 1.0))
    case .playingWithReds:
      return (#colorLiteral(red: 0.827450980392157, green: 0.0627450980392157, blue: 0.152941176470588, alpha: 1.0), #colorLiteral(red: 0.917647058823529, green: 0.219607843137255, blue: 0.301960784313725, alpha: 1.0))
    case .sunnyDays:
      return (#colorLiteral(red: 0.929411764705882, green: 0.898039215686275, blue: 0.454901960784314, alpha: 1.0), #colorLiteral(red: 0.882352941176471, green: 0.96078431372549, blue: 0.768627450980392, alpha: 1.0))
    case .greenBeach:
      return (#colorLiteral(red: 0.00784313725490196, green: 0.666666666666667, blue: 0.690196078431373, alpha: 1.0), #colorLiteral(red: 0.0, green: 0.803921568627451, blue: 0.674509803921569, alpha: 1.0))
    case .intuitivePurple:
      return (#colorLiteral(red: 0.854901960784314, green: 0.133333333333333, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.592156862745098, green: 0.2, blue: 0.933333333333333, alpha: 1.0))
    case .emeraldWater:
      return (#colorLiteral(red: 0.203921568627451, green: 0.56078431372549, blue: 0.313725490196078, alpha: 1.0), #colorLiteral(red: 0.337254901960784, green: 0.705882352941177, blue: 0.827450980392157, alpha: 1.0))
    case .lemonTwist:
      return (#colorLiteral(red: 0.235294117647059, green: 0.647058823529412, blue: 0.36078431372549, alpha: 1.0), #colorLiteral(red: 0.709803921568627, green: 0.674509803921569, blue: 0.286274509803922, alpha: 1.0))
    case .horizon:
      return (#colorLiteral(red: 0.0, green: 0.223529411764706, blue: 0.450980392156863, alpha: 1.0), #colorLiteral(red: 0.898039215686275, green: 0.898039215686275, blue: 0.745098039215686, alpha: 1.0))
    case .roseWater:
      return (#colorLiteral(red: 0.898039215686275, green: 0.364705882352941, blue: 0.529411764705882, alpha: 1.0), #colorLiteral(red: 0.372549019607843, green: 0.764705882352941, blue: 0.894117647058824, alpha: 1.0))
    case .frozen:
      return (#colorLiteral(red: 0.250980392156863, green: 0.231372549019608, blue: 0.290196078431373, alpha: 1.0), #colorLiteral(red: 0.905882352941176, green: 0.913725490196078, blue: 0.733333333333333, alpha: 1.0))
    case .mangoPulp:
      return (#colorLiteral(red: 0.941176470588235, green: 0.596078431372549, blue: 0.0980392156862745, alpha: 1.0), #colorLiteral(red: 0.929411764705882, green: 0.870588235294118, blue: 0.364705882352941, alpha: 1.0))
    case .bloodyMary:
      return (#colorLiteral(red: 1.0, green: 0.317647058823529, blue: 0.184313725490196, alpha: 1.0), #colorLiteral(red: 0.866666666666667, green: 0.141176470588235, blue: 0.462745098039216, alpha: 1.0))
    case .aubergine:
      return (#colorLiteral(red: 0.666666666666667, green: 0.0274509803921569, blue: 0.419607843137255, alpha: 1.0), #colorLiteral(red: 0.380392156862745, green: 0.0156862745098039, blue: 0.372549019607843, alpha: 1.0))
    case .aquaMarine:
      return (#colorLiteral(red: 0.101960784313725, green: 0.16078431372549, blue: 0.501960784313725, alpha: 1.0), #colorLiteral(red: 0.149019607843137, green: 0.815686274509804, blue: 0.807843137254902, alpha: 1.0))
    case .sunrise:
      return (#colorLiteral(red: 1.0, green: 0.317647058823529, blue: 0.184313725490196, alpha: 1.0), #colorLiteral(red: 0.941176470588235, green: 0.596078431372549, blue: 0.0980392156862745, alpha: 1.0))
    case .purpleParadise:
      return (#colorLiteral(red: 0.113725490196078, green: 0.168627450980392, blue: 0.392156862745098, alpha: 1.0), #colorLiteral(red: 0.972549019607843, green: 0.803921568627451, blue: 0.854901960784314, alpha: 1.0))
    case .seaWeed:
      return (#colorLiteral(red: 0.298039215686275, green: 0.72156862745098, blue: 0.768627450980392, alpha: 1.0), #colorLiteral(red: 0.235294117647059, green: 0.827450980392157, blue: 0.67843137254902, alpha: 1.0))
    case .pinky:
      return (#colorLiteral(red: 0.866666666666667, green: 0.368627450980392, blue: 0.537254901960784, alpha: 1.0), #colorLiteral(red: 0.968627450980392, green: 0.733333333333333, blue: 0.592156862745098, alpha: 1.0))
    case .cherry:
      return (#colorLiteral(red: 0.92156862745098, green: 0.2, blue: 0.286274509803922, alpha: 1.0), #colorLiteral(red: 0.956862745098039, green: 0.36078431372549, blue: 0.262745098039216, alpha: 1.0))
    case .mojito:
      return (#colorLiteral(red: 0.113725490196078, green: 0.592156862745098, blue: 0.423529411764706, alpha: 1.0), #colorLiteral(red: 0.576470588235294, green: 0.976470588235294, blue: 0.725490196078431, alpha: 1.0))
    case .juicyOrange:
      return (#colorLiteral(red: 1.0, green: 0.501960784313725, blue: 0.0313725490196078, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.784313725490196, blue: 0.215686274509804, alpha: 1.0))
    case .mirage:
      return (#colorLiteral(red: 0.0862745098039216, green: 0.133333333333333, blue: 0.164705882352941, alpha: 1.0), #colorLiteral(red: 0.227450980392157, green: 0.376470588235294, blue: 0.450980392156863, alpha: 1.0))
    case .steelGray:
      return (#colorLiteral(red: 0.12156862745098, green: 0.109803921568627, blue: 0.172549019607843, alpha: 1.0), #colorLiteral(red: 0.572549019607843, green: 0.552941176470588, blue: 0.670588235294118, alpha: 1.0))
    case .kashmir:
      return (#colorLiteral(red: 0.380392156862745, green: 0.262745098039216, blue: 0.52156862745098, alpha: 1.0), #colorLiteral(red: 0.317647058823529, green: 0.388235294117647, blue: 0.584313725490196, alpha: 1.0))
    case .electricViolet:
      return (#colorLiteral(red: 0.27843137254902, green: 0.462745098039216, blue: 0.901960784313726, alpha: 1.0), #colorLiteral(red: 0.556862745098039, green: 0.329411764705882, blue: 0.913725490196078, alpha: 1.0))
    case .veniceBlue:
      return (#colorLiteral(red: 0.0313725490196078, green: 0.313725490196078, blue: 0.470588235294118, alpha: 1.0), #colorLiteral(red: 0.52156862745098, green: 0.847058823529412, blue: 0.807843137254902, alpha: 1.0))
    case .boraBora:
      return (#colorLiteral(red: 0.168627450980392, green: 0.752941176470588, blue: 0.894117647058824, alpha: 1.0), #colorLiteral(red: 0.917647058823529, green: 0.925490196078431, blue: 0.776470588235294, alpha: 1.0))
    case .moss:
      return (#colorLiteral(red: 0.0745098039215686, green: 0.305882352941176, blue: 0.368627450980392, alpha: 1.0), #colorLiteral(red: 0.443137254901961, green: 0.698039215686274, blue: 0.501960784313725, alpha: 1.0))
    case .shroomHaze:
      return (#colorLiteral(red: 0.36078431372549, green: 0.145098039215686, blue: 0.552941176470588, alpha: 1.0), #colorLiteral(red: 0.262745098039216, green: 0.537254901960784, blue: 0.635294117647059, alpha: 1.0))
    case .mystic:
      return (#colorLiteral(red: 0.458823529411765, green: 0.498039215686275, blue: 0.603921568627451, alpha: 1.0), #colorLiteral(red: 0.843137254901961, green: 0.866666666666667, blue: 0.909803921568627, alpha: 1.0))
    case .midnightCity:
      return (#colorLiteral(red: 0.137254901960784, green: 0.145098039215686, blue: 0.149019607843137, alpha: 1.0), #colorLiteral(red: 0.254901960784314, green: 0.262745098039216, blue: 0.270588235294118, alpha: 1.0))
    case .seaBlizz:
      return (#colorLiteral(red: 0.109803921568627, green: 0.847058823529412, blue: 0.823529411764706, alpha: 1.0), #colorLiteral(red: 0.576470588235294, green: 0.929411764705882, blue: 0.780392156862745, alpha: 1.0))
    case .opa:
      return (#colorLiteral(red: 0.23921568627451, green: 0.494117647058824, blue: 0.666666666666667, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.894117647058824, blue: 0.47843137254902, alpha: 1.0))
    case .titanium:
      return (#colorLiteral(red: 0.156862745098039, green: 0.188235294117647, blue: 0.282352941176471, alpha: 1.0), #colorLiteral(red: 0.52156862745098, green: 0.576470588235294, blue: 0.596078431372549, alpha: 1.0))
    case .mantle:
      return (#colorLiteral(red: 0.141176470588235, green: 0.776470588235294, blue: 0.862745098039216, alpha: 1.0), #colorLiteral(red: 0.317647058823529, green: 0.290196078431373, blue: 0.615686274509804, alpha: 1.0))
    case .dracula:
      return (#colorLiteral(red: 0.862745098039216, green: 0.141176470588235, blue: 0.141176470588235, alpha: 1.0), #colorLiteral(red: 0.290196078431373, green: 0.337254901960784, blue: 0.615686274509804, alpha: 1.0))
    case .peach:
      return (#colorLiteral(red: 0.929411764705882, green: 0.258823529411765, blue: 0.392156862745098, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.929411764705882, blue: 0.737254901960784, alpha: 1.0))
    case .moonrise:
      return (#colorLiteral(red: 0.854901960784314, green: 0.886274509803922, blue: 0.972549019607843, alpha: 1.0), #colorLiteral(red: 0.83921568627451, green: 0.643137254901961, blue: 0.643137254901961, alpha: 1.0))
    case .clouds:
      return (#colorLiteral(red: 0.925490196078431, green: 0.913725490196078, blue: 0.901960784313726, alpha: 1.0), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    case .stellar:
      return (#colorLiteral(red: 0.454901960784314, green: 0.454901960784314, blue: 0.749019607843137, alpha: 1.0), #colorLiteral(red: 0.203921568627451, green: 0.541176470588235, blue: 0.780392156862745, alpha: 1.0))
    case .bourbon:
      return (#colorLiteral(red: 0.925490196078431, green: 0.435294117647059, blue: 0.4, alpha: 1.0), #colorLiteral(red: 0.952941176470588, green: 0.631372549019608, blue: 0.513725490196078, alpha: 1.0))
    case .calmDarya:
      return (#colorLiteral(red: 0.372549019607843, green: 0.172549019607843, blue: 0.509803921568627, alpha: 1.0), #colorLiteral(red: 0.286274509803922, green: 0.627450980392157, blue: 0.615686274509804, alpha: 1.0))
    case .influenza:
      return (#colorLiteral(red: 0.752941176470588, green: 0.282352941176471, blue: 0.282352941176471, alpha: 1.0), #colorLiteral(red: 0.282352941176471, green: 0.0, blue: 0.282352941176471, alpha: 1.0))
    case .shrimpy:
      return (#colorLiteral(red: 0.894117647058824, green: 0.227450980392157, blue: 0.0823529411764706, alpha: 1.0), #colorLiteral(red: 0.901960784313726, green: 0.32156862745098, blue: 0.270588235294118, alpha: 1.0))
    case .army:
      return (#colorLiteral(red: 0.254901960784314, green: 0.301960784313725, blue: 0.0431372549019608, alpha: 1.0), #colorLiteral(red: 0.447058823529412, green: 0.47843137254902, blue: 0.0901960784313725, alpha: 1.0))
    case .miaka:
      return (#colorLiteral(red: 0.988235294117647, green: 0.207843137254902, blue: 0.298039215686275, alpha: 1.0), #colorLiteral(red: 0.0392156862745098, green: 0.749019607843137, blue: 0.737254901960784, alpha: 1.0))
    case .pinotNoir:
      return (#colorLiteral(red: 0.294117647058824, green: 0.423529411764706, blue: 0.717647058823529, alpha: 1.0), #colorLiteral(red: 0.0941176470588235, green: 0.156862745098039, blue: 0.282352941176471, alpha: 1.0))
    case .dayTripper:
      return (#colorLiteral(red: 0.972549019607843, green: 0.341176470588235, blue: 0.650980392156863, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.345098039215686, blue: 0.345098039215686, alpha: 1.0))
    case .namn:
      return (#colorLiteral(red: 0.654901960784314, green: 0.215686274509804, blue: 0.215686274509804, alpha: 1.0), #colorLiteral(red: 0.47843137254902, green: 0.156862745098039, blue: 0.156862745098039, alpha: 1.0))
    case .blurryBeach:
      return (#colorLiteral(red: 0.835294117647059, green: 0.2, blue: 0.411764705882353, alpha: 1.0), #colorLiteral(red: 0.796078431372549, green: 0.67843137254902, blue: 0.427450980392157, alpha: 1.0))
    case .vasily:
      return (#colorLiteral(red: 0.913725490196078, green: 0.827450980392157, blue: 0.384313725490196, alpha: 1.0), #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0))
    case .aLostMemory:
      return (#colorLiteral(red: 0.870588235294118, green: 0.384313725490196, blue: 0.384313725490196, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.72156862745098, blue: 0.549019607843137, alpha: 1.0))
    case .petrichor:
      return (#colorLiteral(red: 0.4, green: 0.4, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.6, green: 0.6, blue: 0.4, alpha: 1.0))
    case .jonquil:
      return (#colorLiteral(red: 1.0, green: 0.933333333333333, blue: 0.933333333333333, alpha: 1.0), #colorLiteral(red: 0.866666666666667, green: 0.937254901960784, blue: 0.733333333333333, alpha: 1.0))
    case .siriusTamed:
      return (#colorLiteral(red: 0.937254901960784, green: 0.937254901960784, blue: 0.733333333333333, alpha: 1.0), #colorLiteral(red: 0.831372549019608, green: 0.827450980392157, blue: 0.866666666666667, alpha: 1.0))
    case .kyoto:
      return (#colorLiteral(red: 0.76078431372549, green: 0.0823529411764706, blue: 0.0, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.772549019607843, blue: 0.0, alpha: 1.0))
    case .mistyMeadow:
      return (#colorLiteral(red: 0.129411764705882, green: 0.372549019607843, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.894117647058824, green: 0.894117647058824, blue: 0.850980392156863, alpha: 1.0))
    case .aqualicious:
      return (#colorLiteral(red: 0.313725490196078, green: 0.788235294117647, blue: 0.764705882352941, alpha: 1.0), #colorLiteral(red: 0.588235294117647, green: 0.870588235294118, blue: 0.854901960784314, alpha: 1.0))
    case .moor:
      return (#colorLiteral(red: 0.380392156862745, green: 0.380392156862745, blue: 0.380392156862745, alpha: 1.0), #colorLiteral(red: 0.607843137254902, green: 0.772549019607843, blue: 0.764705882352941, alpha: 1.0))
    case .almost:
      return (#colorLiteral(red: 0.866666666666667, green: 0.83921568627451, blue: 0.952941176470588, alpha: 1.0), #colorLiteral(red: 0.980392156862745, green: 0.674509803921569, blue: 0.658823529411765, alpha: 1.0))
    case .foreverLost:
      return (#colorLiteral(red: 0.364705882352941, green: 0.254901960784314, blue: 0.341176470588235, alpha: 1.0), #colorLiteral(red: 0.658823529411765, green: 0.792156862745098, blue: 0.729411764705882, alpha: 1.0))
    case .winter:
      return (#colorLiteral(red: 0.901960784313726, green: 0.854901960784314, blue: 0.854901960784314, alpha: 1.0), #colorLiteral(red: 0.152941176470588, green: 0.250980392156863, blue: 0.274509803921569, alpha: 1.0))
    case .autumn:
      return (#colorLiteral(red: 0.854901960784314, green: 0.823529411764706, blue: 0.6, alpha: 1.0), #colorLiteral(red: 0.690196078431373, green: 0.854901960784314, blue: 0.725490196078431, alpha: 1.0))
    case .candy:
      return (#colorLiteral(red: 0.827450980392157, green: 0.584313725490196, blue: 0.607843137254902, alpha: 1.0), #colorLiteral(red: 0.749019607843137, green: 0.901960784313726, blue: 0.729411764705882, alpha: 1.0))
    case .reef:
      return (#colorLiteral(red: 0.0, green: 0.823529411764706, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.227450980392157, green: 0.482352941176471, blue: 0.835294117647059, alpha: 1.0))
    case .theStrain:
      return (#colorLiteral(red: 0.529411764705882, green: 0.0, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.0980392156862745, green: 0.0392156862745098, blue: 0.0196078431372549, alpha: 1.0))
    case .dirtyFog:
      return (#colorLiteral(red: 0.725490196078431, green: 0.576470588235294, blue: 0.83921568627451, alpha: 1.0), #colorLiteral(red: 0.549019607843137, green: 0.650980392156863, blue: 0.858823529411765, alpha: 1.0))
    case .earthly:
      return (#colorLiteral(red: 0.392156862745098, green: 0.568627450980392, blue: 0.450980392156863, alpha: 1.0), #colorLiteral(red: 0.858823529411765, green: 0.835294117647059, blue: 0.643137254901961, alpha: 1.0))
    case .virgin:
      return (#colorLiteral(red: 0.788235294117647, green: 1.0, blue: 0.749019607843137, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.686274509803922, blue: 0.741176470588235, alpha: 1.0))
    case .ash:
      return (#colorLiteral(red: 0.376470588235294, green: 0.423529411764706, blue: 0.533333333333333, alpha: 1.0), #colorLiteral(red: 0.247058823529412, green: 0.298039215686275, blue: 0.419607843137255, alpha: 1.0))
    case .shadowNight:
      return (#colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.325490196078431, green: 0.203921568627451, blue: 0.427450980392157, alpha: 1.0))
    case .cherryblossoms:
      return (#colorLiteral(red: 0.984313725490196, green: 0.827450980392157, blue: 0.913725490196078, alpha: 1.0), #colorLiteral(red: 0.733333333333333, green: 0.215686274509804, blue: 0.490196078431373, alpha: 1.0))
    case .parklife:
      return (#colorLiteral(red: 0.67843137254902, green: 0.819607843137255, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.482352941176471, green: 0.572549019607843, blue: 0.0392156862745098, alpha: 1.0))
    case .danceToForget:
      return (#colorLiteral(red: 1.0, green: 0.305882352941176, blue: 0.313725490196078, alpha: 1.0), #colorLiteral(red: 0.976470588235294, green: 0.831372549019608, blue: 0.137254901960784, alpha: 1.0))
    case .starfall:
      return (#colorLiteral(red: 0.941176470588235, green: 0.76078431372549, blue: 0.482352941176471, alpha: 1.0), #colorLiteral(red: 0.294117647058824, green: 0.0705882352941176, blue: 0.282352941176471, alpha: 1.0))
    case .redMist:
      return (#colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.905882352941176, green: 0.298039215686275, blue: 0.235294117647059, alpha: 1.0))
    case .tealLove:
      return (#colorLiteral(red: 0.666666666666667, green: 1.0, blue: 0.662745098039216, alpha: 1.0), #colorLiteral(red: 0.0666666666666667, green: 1.0, blue: 0.741176470588235, alpha: 1.0))
    case .neonLife:
      return (#colorLiteral(red: 0.701960784313725, green: 1.0, blue: 0.670588235294118, alpha: 1.0), #colorLiteral(red: 0.0705882352941176, green: 1.0, blue: 0.968627450980392, alpha: 1.0))
    case .manOfSteel:
      return (#colorLiteral(red: 0.470588235294118, green: 0.00784313725490196, blue: 0.0235294117647059, alpha: 1.0), #colorLiteral(red: 0.0235294117647059, green: 0.0666666666666667, blue: 0.380392156862745, alpha: 1.0))
    case .amethyst:
      return (#colorLiteral(red: 0.615686274509804, green: 0.313725490196078, blue: 0.733333333333333, alpha: 1.0), #colorLiteral(red: 0.431372549019608, green: 0.282352941176471, blue: 0.666666666666667, alpha: 1.0))
    case .cheerUpEmoKid:
      return (#colorLiteral(red: 0.333333333333333, green: 0.384313725490196, blue: 0.43921568627451, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.419607843137255, blue: 0.419607843137255, alpha: 1.0))
    case .shore:
      return (#colorLiteral(red: 0.43921568627451, green: 0.882352941176471, blue: 0.96078431372549, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.819607843137255, blue: 0.580392156862745, alpha: 1.0))
    case .facebookMessenger:
      return (#colorLiteral(red: 0.0, green: 0.776470588235294, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.0, green: 0.447058823529412, blue: 1.0, alpha: 1.0))
    case .soundcloud:
      return (#colorLiteral(red: 0.996078431372549, green: 0.549019607843137, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.972549019607843, green: 0.211764705882353, blue: 0.0, alpha: 1.0))
    case .behongo:
      return (#colorLiteral(red: 0.32156862745098, green: 0.76078431372549, blue: 0.203921568627451, alpha: 1.0), #colorLiteral(red: 0.0235294117647059, green: 0.0901960784313725, blue: 0.0, alpha: 1.0))
    case .servquick:
      return (#colorLiteral(red: 0.282352941176471, green: 0.333333333333333, blue: 0.388235294117647, alpha: 1.0), #colorLiteral(red: 0.16078431372549, green: 0.196078431372549, blue: 0.235294117647059, alpha: 1.0))
    case .friday:
      return (#colorLiteral(red: 0.513725490196078, green: 0.643137254901961, blue: 0.831372549019608, alpha: 1.0), #colorLiteral(red: 0.713725490196078, green: 0.984313725490196, blue: 1.0, alpha: 1.0))
    case .martini:
      return (#colorLiteral(red: 0.992156862745098, green: 0.988235294117647, blue: 0.27843137254902, alpha: 1.0), #colorLiteral(red: 0.141176470588235, green: 0.996078431372549, blue: 0.254901960784314, alpha: 1.0))
    case .metallicToad:
      return (#colorLiteral(red: 0.670588235294118, green: 0.729411764705882, blue: 0.670588235294118, alpha: 1.0), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    case .betweenTheClouds:
      return (#colorLiteral(red: 0.450980392156863, green: 0.784313725490196, blue: 0.662745098039216, alpha: 1.0), #colorLiteral(red: 0.215686274509804, green: 0.231372549019608, blue: 0.266666666666667, alpha: 1.0))
    case .crazyOrangeI:
      return (#colorLiteral(red: 0.827450980392157, green: 0.513725490196078, blue: 0.0705882352941176, alpha: 1.0), #colorLiteral(red: 0.658823529411765, green: 0.196078431372549, blue: 0.474509803921569, alpha: 1.0))
    case .hersheys:
      return (#colorLiteral(red: 0.117647058823529, green: 0.0745098039215686, blue: 0.0470588235294118, alpha: 1.0), #colorLiteral(red: 0.603921568627451, green: 0.517647058823529, blue: 0.470588235294118, alpha: 1.0))
    case .talkingToMiceElf:
      return (#colorLiteral(red: 0.580392156862745, green: 0.556862745098039, blue: 0.6, alpha: 1.0), #colorLiteral(red: 0.180392156862745, green: 0.0784313725490196, blue: 0.215686274509804, alpha: 1.0))
    case .purpleBliss:
      return (#colorLiteral(red: 0.211764705882353, green: 0.0, blue: 0.2, alpha: 1.0), #colorLiteral(red: 0.0431372549019608, green: 0.529411764705882, blue: 0.576470588235294, alpha: 1.0))
    case .predawn:
      return (#colorLiteral(red: 1.0, green: 0.631372549019608, blue: 0.498039215686275, alpha: 1.0), #colorLiteral(red: 0.0, green: 0.133333333333333, blue: 0.243137254901961, alpha: 1.0))
    case .endlessRiver:
      return (#colorLiteral(red: 0.262745098039216, green: 0.807843137254902, blue: 0.635294117647059, alpha: 1.0), #colorLiteral(red: 0.0941176470588235, green: 0.352941176470588, blue: 0.615686274509804, alpha: 1.0))
    case .pastelOrangeAtTheSun:
      return (#colorLiteral(red: 1.0, green: 0.701960784313725, blue: 0.27843137254902, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.8, blue: 0.2, alpha: 1.0))
    case .twitch:
      return (#colorLiteral(red: 0.392156862745098, green: 0.254901960784314, blue: 0.647058823529412, alpha: 1.0), #colorLiteral(red: 0.164705882352941, green: 0.0313725490196078, blue: 0.270588235294118, alpha: 1.0))
    case .instagram:
      return (#colorLiteral(red: 0.317647058823529, green: 0.498039215686275, blue: 0.643137254901961, alpha: 1.0), #colorLiteral(red: 0.141176470588235, green: 0.223529411764706, blue: 0.286274509803922, alpha: 1.0))
    case .flickr:
      return (#colorLiteral(red: 1.0, green: 0.0, blue: 0.517647058823529, alpha: 1.0), #colorLiteral(red: 0.2, green: 0.0, blue: 0.105882352941176, alpha: 1.0))
    case .vine:
      return (#colorLiteral(red: 0.0, green: 0.749019607843137, blue: 0.56078431372549, alpha: 1.0), #colorLiteral(red: 0.0, green: 0.0823529411764706, blue: 0.0627450980392157, alpha: 1.0))
    case .turquoiseFlow:
      return (#colorLiteral(red: 0.0745098039215686, green: 0.415686274509804, blue: 0.541176470588235, alpha: 1.0), #colorLiteral(red: 0.149019607843137, green: 0.470588235294118, blue: 0.443137254901961, alpha: 1.0))
    case .portrait:
      return (#colorLiteral(red: 0.556862745098039, green: 0.619607843137255, blue: 0.670588235294118, alpha: 1.0), #colorLiteral(red: 0.933333333333333, green: 0.949019607843137, blue: 0.952941176470588, alpha: 1.0))
    case .virginAmerica:
      return (#colorLiteral(red: 0.482352941176471, green: 0.262745098039216, blue: 0.592156862745098, alpha: 1.0), #colorLiteral(red: 0.862745098039216, green: 0.141176470588235, blue: 0.188235294117647, alpha: 1.0))
    case .kokoCaramel:
      return (#colorLiteral(red: 0.819607843137255, green: 0.568627450980392, blue: 0.235294117647059, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.819607843137255, blue: 0.580392156862745, alpha: 1.0))
    case .freshTurboscent:
      return (#colorLiteral(red: 0.945098039215686, green: 0.949019607843137, blue: 0.709803921568627, alpha: 1.0), #colorLiteral(red: 0.0745098039215686, green: 0.313725490196078, blue: 0.345098039215686, alpha: 1.0))
    case .greenToDark:
      return (#colorLiteral(red: 0.415686274509804, green: 0.568627450980392, blue: 0.0745098039215686, alpha: 1.0), #colorLiteral(red: 0.0784313725490196, green: 0.0823529411764706, blue: 0.0901960784313725, alpha: 1.0))
    case .ukraine:
      return (#colorLiteral(red: 0.0, green: 0.309803921568627, blue: 0.976470588235294, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.976470588235294, blue: 0.298039215686275, alpha: 1.0))
    case .curiosityBlue:
      return (#colorLiteral(red: 0.32156862745098, green: 0.32156862745098, blue: 0.32156862745098, alpha: 1.0), #colorLiteral(red: 0.23921568627451, green: 0.447058823529412, blue: 0.705882352941177, alpha: 1.0))
    case .darkKnight:
      return (#colorLiteral(red: 0.729411764705882, green: 0.545098039215686, blue: 0.00784313725490196, alpha: 1.0), #colorLiteral(red: 0.0941176470588235, green: 0.0941176470588235, blue: 0.0941176470588235, alpha: 1.0))
    case .piglet:
      return (#colorLiteral(red: 0.933333333333333, green: 0.611764705882353, blue: 0.654901960784314, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.866666666666667, blue: 0.882352941176471, alpha: 1.0))
    case .lizard:
      return (#colorLiteral(red: 0.188235294117647, green: 0.262745098039216, blue: 0.32156862745098, alpha: 1.0), #colorLiteral(red: 0.843137254901961, green: 0.823529411764706, blue: 0.8, alpha: 1.0))
    case .sagePersuasion:
      return (#colorLiteral(red: 0.8, green: 0.8, blue: 0.698039215686274, alpha: 1.0), #colorLiteral(red: 0.458823529411765, green: 0.458823529411765, blue: 0.0980392156862745, alpha: 1.0))
    case .betweenNightAndDay:
      return (#colorLiteral(red: 0.172549019607843, green: 0.243137254901961, blue: 0.313725490196078, alpha: 1.0), #colorLiteral(red: 0.203921568627451, green: 0.596078431372549, blue: 0.858823529411765, alpha: 1.0))
    case .timber:
      return (#colorLiteral(red: 0.988235294117647, green: 0.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.0, green: 0.858823529411765, blue: 0.870588235294118, alpha: 1.0))
    case .passion:
      return (#colorLiteral(red: 0.898039215686275, green: 0.223529411764706, blue: 0.207843137254902, alpha: 1.0), #colorLiteral(red: 0.890196078431372, green: 0.364705882352941, blue: 0.356862745098039, alpha: 1.0))
    case .clearSky:
      return (#colorLiteral(red: 0.0, green: 0.36078431372549, blue: 0.592156862745098, alpha: 1.0), #colorLiteral(red: 0.211764705882353, green: 0.215686274509804, blue: 0.584313725490196, alpha: 1.0))
    case .masterCard:
      return (#colorLiteral(red: 0.956862745098039, green: 0.419607843137255, blue: 0.270588235294118, alpha: 1.0), #colorLiteral(red: 0.933333333333333, green: 0.658823529411765, blue: 0.286274509803922, alpha: 1.0))
    case .backToEarth:
      return (#colorLiteral(red: 0.0, green: 0.788235294117647, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.572549019607843, green: 0.996078431372549, blue: 0.615686274509804, alpha: 1.0))
    case .deepPurple:
      return (#colorLiteral(red: 0.403921568627451, green: 0.227450980392157, blue: 0.717647058823529, alpha: 1.0), #colorLiteral(red: 0.317647058823529, green: 0.176470588235294, blue: 0.658823529411765, alpha: 1.0))
    case .littleLeaf:
      return (#colorLiteral(red: 0.462745098039216, green: 0.72156862745098, blue: 0.32156862745098, alpha: 1.0), #colorLiteral(red: 0.552941176470588, green: 0.76078431372549, blue: 0.435294117647059, alpha: 1.0))
    case .netflix:
      return (#colorLiteral(red: 0.556862745098039, green: 0.0549019607843137, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.12156862745098, green: 0.109803921568627, blue: 0.0941176470588235, alpha: 1.0))
    case .lightOrange:
      return (#colorLiteral(red: 1.0, green: 0.717647058823529, blue: 0.368627450980392, alpha: 1.0), #colorLiteral(red: 0.929411764705882, green: 0.56078431372549, blue: 0.0117647058823529, alpha: 1.0))
    case .greenAndBlue:
      return (#colorLiteral(red: 0.76078431372549, green: 0.898039215686275, blue: 0.611764705882353, alpha: 1.0), #colorLiteral(red: 0.392156862745098, green: 0.701960784313725, blue: 0.956862745098039, alpha: 1.0))
    case .poncho:
      return (#colorLiteral(red: 0.250980392156863, green: 0.227450980392157, blue: 0.243137254901961, alpha: 1.0), #colorLiteral(red: 0.745098039215686, green: 0.345098039215686, blue: 0.411764705882353, alpha: 1.0))
    case .backToTheFuture:
      return (#colorLiteral(red: 0.752941176470588, green: 0.141176470588235, blue: 0.145098039215686, alpha: 1.0), #colorLiteral(red: 0.941176470588235, green: 0.796078431372549, blue: 0.207843137254902, alpha: 1.0))
    case .blush:
      return (#colorLiteral(red: 0.698039215686274, green: 0.270588235294118, blue: 0.572549019607843, alpha: 1.0), #colorLiteral(red: 0.945098039215686, green: 0.372549019607843, blue: 0.474509803921569, alpha: 1.0))
    case .inbox:
      return (#colorLiteral(red: 0.270588235294118, green: 0.498039215686275, blue: 0.792156862745098, alpha: 1.0), #colorLiteral(red: 0.337254901960784, green: 0.568627450980392, blue: 0.784313725490196, alpha: 1.0))
    case .purplin:
      return (#colorLiteral(red: 0.415686274509804, green: 0.188235294117647, blue: 0.576470588235294, alpha: 1.0), #colorLiteral(red: 0.627450980392157, green: 0.266666666666667, blue: 1.0, alpha: 1.0))
    case .paleWood:
      return (#colorLiteral(red: 0.917647058823529, green: 0.803921568627451, blue: 0.63921568627451, alpha: 1.0), #colorLiteral(red: 0.83921568627451, green: 0.682352941176471, blue: 0.482352941176471, alpha: 1.0))
    case .haikus:
      return (#colorLiteral(red: 0.992156862745098, green: 0.454901960784314, blue: 0.423529411764706, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.564705882352941, blue: 0.407843137254902, alpha: 1.0))
    case .pizelex:
      return (#colorLiteral(red: 0.0666666666666667, green: 0.262745098039216, blue: 0.341176470588235, alpha: 1.0), #colorLiteral(red: 0.949019607843137, green: 0.580392156862745, blue: 0.572549019607843, alpha: 1.0))
    case .joomla:
      return (#colorLiteral(red: 0.117647058823529, green: 0.235294117647059, blue: 0.447058823529412, alpha: 1.0), #colorLiteral(red: 0.164705882352941, green: 0.32156862745098, blue: 0.596078431372549, alpha: 1.0))
    case .christmas:
      return (#colorLiteral(red: 0.184313725490196, green: 0.450980392156863, blue: 0.211764705882353, alpha: 1.0), #colorLiteral(red: 0.666666666666667, green: 0.227450980392157, blue: 0.219607843137255, alpha: 1.0))
    case .minnesotaVikings:
      return (#colorLiteral(red: 0.337254901960784, green: 0.0784313725490196, blue: 0.690196078431373, alpha: 1.0), #colorLiteral(red: 0.858823529411765, green: 0.83921568627451, blue: 0.36078431372549, alpha: 1.0))
    case .miamiDolphins:
      return (#colorLiteral(red: 0.301960784313725, green: 0.627450980392157, blue: 0.690196078431373, alpha: 1.0), #colorLiteral(red: 0.827450980392157, green: 0.615686274509804, blue: 0.219607843137255, alpha: 1.0))
    case .forest:
      return (#colorLiteral(red: 0.352941176470588, green: 0.247058823529412, blue: 0.215686274509804, alpha: 1.0), #colorLiteral(red: 0.172549019607843, green: 0.466666666666667, blue: 0.266666666666667, alpha: 1.0))
    case .nighthawk:
      return (#colorLiteral(red: 0.16078431372549, green: 0.501960784313725, blue: 0.725490196078431, alpha: 1.0), #colorLiteral(red: 0.172549019607843, green: 0.243137254901961, blue: 0.313725490196078, alpha: 1.0))
    case .superman:
      return (#colorLiteral(red: 0.0, green: 0.6, blue: 0.968627450980392, alpha: 1.0), #colorLiteral(red: 0.945098039215686, green: 0.0901960784313725, blue: 0.0705882352941176, alpha: 1.0))
    case .suzy:
      return (#colorLiteral(red: 0.513725490196078, green: 0.301960784313725, blue: 0.607843137254902, alpha: 1.0), #colorLiteral(red: 0.815686274509804, green: 0.305882352941176, blue: 0.83921568627451, alpha: 1.0))
    case .darkSkies:
      return (#colorLiteral(red: 0.294117647058824, green: 0.474509803921569, blue: 0.631372549019608, alpha: 1.0), #colorLiteral(red: 0.156862745098039, green: 0.243137254901961, blue: 0.317647058823529, alpha: 1.0))
    case .deepSpace:
      return (#colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.262745098039216, green: 0.262745098039216, blue: 0.262745098039216, alpha: 1.0))
    case .decent:
      return (#colorLiteral(red: 0.298039215686275, green: 0.631372549019608, blue: 0.686274509803922, alpha: 1.0), #colorLiteral(red: 0.768627450980392, green: 0.87843137254902, blue: 0.898039215686275, alpha: 1.0))
    case .colorsOfSky:
      return (#colorLiteral(red: 0.87843137254902, green: 0.917647058823529, blue: 0.988235294117647, alpha: 1.0), #colorLiteral(red: 0.811764705882353, green: 0.870588235294118, blue: 0.952941176470588, alpha: 1.0))
    case .purpleWhite:
      return (#colorLiteral(red: 0.729411764705882, green: 0.325490196078431, blue: 0.43921568627451, alpha: 1.0), #colorLiteral(red: 0.956862745098039, green: 0.886274509803922, blue: 0.847058823529412, alpha: 1.0))
    case .ali:
      return (#colorLiteral(red: 1.0, green: 0.294117647058824, blue: 0.12156862745098, alpha: 1.0), #colorLiteral(red: 0.12156862745098, green: 0.866666666666667, blue: 1.0, alpha: 1.0))
    case .alihossein:
      return (#colorLiteral(red: 0.968627450980392, green: 1.0, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.858823529411765, green: 0.211764705882353, blue: 0.643137254901961, alpha: 1.0))
    case .shahabi:
      return (#colorLiteral(red: 0.658823529411765, green: 0.0, blue: 0.466666666666667, alpha: 1.0), #colorLiteral(red: 0.4, green: 1.0, blue: 0.0, alpha: 1.0))
    case .redOcean:
      return (#colorLiteral(red: 0.113725490196078, green: 0.262745098039216, blue: 0.313725490196078, alpha: 1.0), #colorLiteral(red: 0.643137254901961, green: 0.223529411764706, blue: 0.192156862745098, alpha: 1.0))
    case .tranquil:
      return (#colorLiteral(red: 0.933333333333333, green: 0.803921568627451, blue: 0.63921568627451, alpha: 1.0), #colorLiteral(red: 0.937254901960784, green: 0.384313725490196, blue: 0.623529411764706, alpha: 1.0))
    case .transfile:
      return (#colorLiteral(red: 0.0862745098039216, green: 0.749019607843137, blue: 0.992156862745098, alpha: 1.0), #colorLiteral(red: 0.796078431372549, green: 0.188235294117647, blue: 0.4, alpha: 1.0))
    case .sylvia:
      return (#colorLiteral(red: 1.0, green: 0.294117647058824, blue: 0.12156862745098, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.564705882352941, blue: 0.407843137254902, alpha: 1.0))
    case .sweetMorning:
      return (#colorLiteral(red: 1.0, green: 0.372549019607843, blue: 0.427450980392157, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.764705882352941, blue: 0.443137254901961, alpha: 1.0))
    case .politics:
      return (#colorLiteral(red: 0.129411764705882, green: 0.588235294117647, blue: 0.952941176470588, alpha: 1.0), #colorLiteral(red: 0.956862745098039, green: 0.262745098039216, blue: 0.211764705882353, alpha: 1.0))
    case .brightVault:
      return (#colorLiteral(red: 0.0, green: 0.823529411764706, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.572549019607843, green: 0.552941176470588, blue: 0.670588235294118, alpha: 1.0))
    case .solidVault:
      return (#colorLiteral(red: 0.227450980392157, green: 0.482352941176471, blue: 0.835294117647059, alpha: 1.0), #colorLiteral(red: 0.227450980392157, green: 0.376470588235294, blue: 0.450980392156863, alpha: 1.0))
    case .sunset:
      return (#colorLiteral(red: 0.0431372549019608, green: 0.282352941176471, blue: 0.419607843137255, alpha: 1.0), #colorLiteral(red: 0.96078431372549, green: 0.384313725490196, blue: 0.0901960784313725, alpha: 1.0))
    case .grapefruitSunset:
      return (#colorLiteral(red: 0.913725490196078, green: 0.392156862745098, blue: 0.262745098039216, alpha: 1.0), #colorLiteral(red: 0.564705882352941, green: 0.305882352941176, blue: 0.584313725490196, alpha: 1.0))
    case .deepSeaSpace:
      return (#colorLiteral(red: 0.172549019607843, green: 0.243137254901961, blue: 0.313725490196078, alpha: 1.0), #colorLiteral(red: 0.298039215686275, green: 0.631372549019608, blue: 0.686274509803922, alpha: 1.0))
    case .dusk:
      return (#colorLiteral(red: 0.172549019607843, green: 0.243137254901961, blue: 0.313725490196078, alpha: 1.0), #colorLiteral(red: 0.992156862745098, green: 0.454901960784314, blue: 0.423529411764706, alpha: 1.0))
    case .minimalRed:
      return (#colorLiteral(red: 0.941176470588235, green: 0.0, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.862745098039216, green: 0.156862745098039, blue: 0.117647058823529, alpha: 1.0))
    case .royal:
      return (#colorLiteral(red: 0.0784313725490196, green: 0.117647058823529, blue: 0.188235294117647, alpha: 1.0), #colorLiteral(red: 0.141176470588235, green: 0.231372549019608, blue: 0.333333333333333, alpha: 1.0))
    case .mauve:
      return (#colorLiteral(red: 0.258823529411765, green: 0.152941176470588, blue: 0.352941176470588, alpha: 1.0), #colorLiteral(red: 0.450980392156863, green: 0.294117647058824, blue: 0.427450980392157, alpha: 1.0))
    case .frost:
      return (#colorLiteral(red: 0.0, green: 0.0156862745098039, blue: 0.156862745098039, alpha: 1.0), #colorLiteral(red: 0.0, green: 0.305882352941176, blue: 0.572549019607843, alpha: 1.0))
    case .lush:
      return (#colorLiteral(red: 0.337254901960784, green: 0.670588235294118, blue: 0.184313725490196, alpha: 1.0), #colorLiteral(red: 0.658823529411765, green: 0.87843137254902, blue: 0.388235294117647, alpha: 1.0))
    case .firewatch:
      return (#colorLiteral(red: 0.796078431372549, green: 0.176470588235294, blue: 0.243137254901961, alpha: 1.0), #colorLiteral(red: 0.937254901960784, green: 0.27843137254902, blue: 0.227450980392157, alpha: 1.0))
    case .sherbert:
      return (#colorLiteral(red: 0.968627450980392, green: 0.615686274509804, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.392156862745098, green: 0.952941176470588, blue: 0.549019607843137, alpha: 1.0))
    case .bloodRed:
      return (#colorLiteral(red: 0.972549019607843, green: 0.313725490196078, blue: 0.196078431372549, alpha: 1.0), #colorLiteral(red: 0.905882352941176, green: 0.219607843137255, blue: 0.152941176470588, alpha: 1.0))
    case .sunOnTheHorizon:
      return (#colorLiteral(red: 0.988235294117647, green: 0.917647058823529, blue: 0.733333333333333, alpha: 1.0), #colorLiteral(red: 0.972549019607843, green: 0.709803921568627, blue: 0.0, alpha: 1.0))
    case .iiitDelhi:
      return (#colorLiteral(red: 0.501960784313725, green: 0.501960784313725, blue: 0.501960784313725, alpha: 1.0), #colorLiteral(red: 0.247058823529412, green: 0.67843137254902, blue: 0.658823529411765, alpha: 1.0))
    }
  }
}
