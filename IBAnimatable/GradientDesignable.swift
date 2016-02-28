//
//  Created by Jake Lin on 12/4/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol GradientDesignable {
  var startColor: UIColor? { get set }
  var endColor: UIColor? { get set }
  var predefinedGradient: String? { get set }
  var startPoint: String? { get set }
}

public extension GradientDesignable where Self: UIView {

  public func configGradient() {
    let predefinedGradient = configPredefinedGradient()
    if let unwrappedStartColor = startColor, unwrappedEndColor = endColor {
      configGradientWithStartColor(unwrappedStartColor, endColor: unwrappedEndColor)
    } else if let unwrappedStartColor = predefinedGradient?.0, unwrappedEndColor = predefinedGradient?.1 {
      configGradientWithStartColor(unwrappedStartColor, endColor: unwrappedEndColor)
    }
  }

  private func configGradientWithStartColor(startColor: UIColor, endColor: UIColor) {
    // Default value is `.Top`
    var gradientStartPoint: GradientStartPoint = .Top
    if let unwrappedStartPoint = startPoint, resolvedGradientStartPoint = GradientStartPoint(rawValue: unwrappedStartPoint) {
      gradientStartPoint = resolvedGradientStartPoint
    }
    
    let gradientLayer = createGradientLayer()
    gradientLayer.colors = [startColor.CGColor, endColor.CGColor]    
    switch gradientStartPoint {
    case .Top:
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    case .TopRight:
      gradientLayer.startPoint = CGPoint(x: 1, y: 0)
      gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    case .Right:
      gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
    case .BottomRight:
      gradientLayer.startPoint = CGPoint(x: 1, y: 1)
      gradientLayer.endPoint = CGPoint(x: 0, y: 0)
    case .Bottom:
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
    case .BottomLeft:
      gradientLayer.startPoint = CGPoint(x: 0, y: 1)
      gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    case .Left:
      gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    case .TopLeft:
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
    
    let gradientView = GradientView(frame: bounds, layer: gradientLayer)
    let oldGradientView = viewWithTag(gradientView.tag)
    oldGradientView?.removeFromSuperview()
    self.insertSubview(gradientView, atIndex: 0)
  }
  
  private func createGradientLayer() -> CAGradientLayer {
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    return gradientLayer
  }
  
  private func configPredefinedGradient() -> (UIColor, UIColor)? {
    guard let unwrappedGradientTypeString = predefinedGradient, gradientType = GradientType(rawValue: unwrappedGradientTypeString) else {
        return nil
    }
    
    switch gradientType {
    case .SunnyDays:
      return (UIColor(hexString: "#EDE574"), UIColor(hexString: "#E1F5C4"))
    case .GreenBeach:
      return (UIColor(hexString: "#02AAB0"), UIColor(hexString: "#00CDAC"))
    case .IntuitivePurple:
      return (UIColor(hexString: "#DA22FF"), UIColor(hexString: "#9733EE"))
    case .EmeraldWater:
      return (UIColor(hexString: "#348F50"), UIColor(hexString: "#56B4D3"))
    case .LemonTwist:
      return (UIColor(hexString: "#3CA55C"), UIColor(hexString: "#B5AC49"))
    case .Horizon:
      return (UIColor(hexString: "#003973"), UIColor(hexString: "#E5E5BE"))
    case .RoseWater:
      return (UIColor(hexString: "#E55D87"), UIColor(hexString: "#5FC3E4"))
    case .Frozen:
      return (UIColor(hexString: "#403B4A"), UIColor(hexString: "#E7E9BB"))
    case .MangoPulp:
      return (UIColor(hexString: "#F09819"), UIColor(hexString: "#EDDE5D"))
    case .BloodyMary:
      return (UIColor(hexString: "#FF512F"), UIColor(hexString: "#DD2476"))
    case .Aubergine:
      return (UIColor(hexString: "#AA076B"), UIColor(hexString: "#61045F"))
    case .AquaMarine:
      return (UIColor(hexString: "#1A2980"), UIColor(hexString: "#26D0CE"))
    case .Sunrise:
      return (UIColor(hexString: "#FF512F"), UIColor(hexString: "#F09819"))
    case .PurpleParadise:
      return (UIColor(hexString: "#1D2B64"), UIColor(hexString: "#F8CDDA"))
    case .SeaWeed:
      return (UIColor(hexString: "#4CB8C4"), UIColor(hexString: "#3CD3AD"))
    case .Pinky:
      return (UIColor(hexString: "#DD5E89"), UIColor(hexString: "#F7BB97"))
    case .Cherry:
      return (UIColor(hexString: "#EB3349"), UIColor(hexString: "#F45C43"))
    case .Mojito:
      return (UIColor(hexString: "#1D976C"), UIColor(hexString: "#93F9B9"))
    case .JuicyOrange:
      return (UIColor(hexString: "#FF8008"), UIColor(hexString: "#FFC837"))
    case .Mirage:
      return (UIColor(hexString: "#16222A"), UIColor(hexString: "#3A6073"))
    case .SteelGray:
      return (UIColor(hexString: "#1F1C2C"), UIColor(hexString: "#928DAB"))
    case .Kashmir:
      return (UIColor(hexString: "#614385"), UIColor(hexString: "#516395"))
    case .ElectricViolet:
      return (UIColor(hexString: "#4776E6"), UIColor(hexString: "#8E54E9"))
    case .VeniceBlue:
      return (UIColor(hexString: "#085078"), UIColor(hexString: "#85D8CE"))
    case .BoraBora:
      return (UIColor(hexString: "#2BC0E4"), UIColor(hexString: "#EAECC6"))
    case .Moss:
      return (UIColor(hexString: "#134E5E"), UIColor(hexString: "#71B280"))
    case .ShroomHaze:
      return (UIColor(hexString: "#5C258D"), UIColor(hexString: "#4389A2"))
    case .Mystic:
      return (UIColor(hexString: "#757F9A"), UIColor(hexString: "#D7DDE8"))
    case .MidnightCity:
      return (UIColor(hexString: "#232526"), UIColor(hexString: "#414345"))
    case .SeaBlizz:
      return (UIColor(hexString: "#1CD8D2"), UIColor(hexString: "#93EDC7"))
    case .Opa:
      return (UIColor(hexString: "#3D7EAA"), UIColor(hexString: "#FFE47A"))
    case .Titanium:
      return (UIColor(hexString: "#283048"), UIColor(hexString: "#859398"))
    case .Mantle:
      return (UIColor(hexString: "#24C6DC"), UIColor(hexString: "#514A9D"))
    case .Dracula:
      return (UIColor(hexString: "#DC2424"), UIColor(hexString: "#4A569D"))
    case .Peach:
      return (UIColor(hexString: "#ED4264"), UIColor(hexString: "#FFEDBC"))
    case .Moonrise:
      return (UIColor(hexString: "#DAE2F8"), UIColor(hexString: "#D6A4A4"))
    case .Clouds:
      return (UIColor(hexString: "#ECE9E6"), UIColor(hexString: "#FFFFFF"))
    case .Stellar:
      return (UIColor(hexString: "#7474BF"), UIColor(hexString: "#348AC7"))
    case .Bourbon:
      return (UIColor(hexString: "#EC6F66"), UIColor(hexString: "#F3A183"))
    case .CalmDarya:
      return (UIColor(hexString: "#5f2c82"), UIColor(hexString: "#49a09d"))
    case .Influenza:
      return (UIColor(hexString: "#C04848"), UIColor(hexString: "#480048"))
    case .Shrimpy:
      return (UIColor(hexString: "#e43a15"), UIColor(hexString: "#e65245"))
    case .Army:
      return (UIColor(hexString: "#414d0b"), UIColor(hexString: "#727a17"))
    case .Miaka:
      return (UIColor(hexString: "#FC354C"), UIColor(hexString: "#0ABFBC"))
    case .PinotNoir:
      return (UIColor(hexString: "#4b6cb7"), UIColor(hexString: "#182848"))
    case .DayTripper:
      return (UIColor(hexString: "#f857a6"), UIColor(hexString: "#ff5858"))
    case .Namn:
      return (UIColor(hexString: "#a73737"), UIColor(hexString: "#7a2828"))
    case .BlurryBeach:
      return (UIColor(hexString: "#d53369"), UIColor(hexString: "#cbad6d"))
    case .Vasily:
      return (UIColor(hexString: "#e9d362"), UIColor(hexString: "#333333"))
    case .ALostMemory:
      return (UIColor(hexString: "#DE6262"), UIColor(hexString: "#FFB88C"))
    case .Petrichor:
      return (UIColor(hexString: "#666600"), UIColor(hexString: "#999966"))
    case .Jonquil:
      return (UIColor(hexString: "#FFEEEE"), UIColor(hexString: "#DDEFBB"))
    case .SiriusTamed:
      return (UIColor(hexString: "#EFEFBB"), UIColor(hexString: "#D4D3DD"))
    case .Kyoto:
      return (UIColor(hexString: "#c21500"), UIColor(hexString: "#ffc500"))
    case .MistyMeadow:
      return (UIColor(hexString: "#215f00"), UIColor(hexString: "#e4e4d9"))
    case .Aqualicious:
      return (UIColor(hexString: "#50C9C3"), UIColor(hexString: "#96DEDA"))
    case .Moor:
      return (UIColor(hexString: "#616161"), UIColor(hexString: "#9bc5c3"))
    case .Almost:
      return (UIColor(hexString: "#ddd6f3"), UIColor(hexString: "#faaca8"))
    case .ForeverLost:
      return (UIColor(hexString: "#5D4157"), UIColor(hexString: "#A8CABA"))
    case .Winter:
      return (UIColor(hexString: "#E6DADA"), UIColor(hexString: "#274046"))
    case .Autumn:
      return (UIColor(hexString: "#DAD299"), UIColor(hexString: "#B0DAB9"))
    case .Candy:
      return (UIColor(hexString: "#D3959B"), UIColor(hexString: "#BFE6BA"))
    case .Reef:
      return (UIColor(hexString: "#00d2ff"), UIColor(hexString: "#3a7bd5"))
    case .TheStrain:
      return (UIColor(hexString: "#870000"), UIColor(hexString: "#190A05"))
    case .DirtyFog:
      return (UIColor(hexString: "#B993D6"), UIColor(hexString: "#8CA6DB"))
    case .Earthly:
      return (UIColor(hexString: "#649173"), UIColor(hexString: "#DBD5A4"))
    case .Virgin:
      return (UIColor(hexString: "#C9FFBF"), UIColor(hexString: "#FFAFBD"))
    case .Ash:
      return (UIColor(hexString: "#606c88"), UIColor(hexString: "#3f4c6b"))
    case .ShadowNight:
      return (UIColor(hexString: "#000000"), UIColor(hexString: "#53346D"))
    case .Cherryblossoms:
      return (UIColor(hexString: "#FBD3E9"), UIColor(hexString: "#BB377D"))
    case .Parklife:
      return (UIColor(hexString: "#ADD100"), UIColor(hexString: "#7B920A"))
    case .DanceToForget:
      return (UIColor(hexString: "#FF4E50"), UIColor(hexString: "#F9D423"))
    case .Starfall:
      return (UIColor(hexString: "#F0C27B"), UIColor(hexString: "#4B1248"))
    case .RedMist:
      return (UIColor(hexString: "#000000"), UIColor(hexString: "#e74c3c"))
    case .TealLove:
      return (UIColor(hexString: "#AAFFA9"), UIColor(hexString: "#11FFBD"))
    case .NeonLife:
      return (UIColor(hexString: "#B3FFAB"), UIColor(hexString: "#12FFF7"))
    case .ManofSteel:
      return (UIColor(hexString: "#780206"), UIColor(hexString: "#061161"))
    case .Amethyst:
      return (UIColor(hexString: "#9D50BB"), UIColor(hexString: "#6E48AA"))
    case .CheerUpEmoKid:
      return (UIColor(hexString: "#556270"), UIColor(hexString: "#FF6B6B"))
    case .Shore:
      return (UIColor(hexString: "#70e1f5"), UIColor(hexString: "#ffd194"))
    case .FacebookMessenger:
      return (UIColor(hexString: "#00c6ff"), UIColor(hexString: "#0072ff"))
    case .SoundCloud:
      return (UIColor(hexString: "#fe8c00"), UIColor(hexString: "#f83600"))
    case .Behongo:
      return (UIColor(hexString: "#52c234"), UIColor(hexString: "#061700"))
    case .ServQuick:
      return (UIColor(hexString: "#485563"), UIColor(hexString: "#29323c"))
    case .Friday:
      return (UIColor(hexString: "#83a4d4"), UIColor(hexString: "#b6fbff"))
    case .Martini:
      return (UIColor(hexString: "#FDFC47"), UIColor(hexString: "#24FE41"))
    case .MetallicToad:
      return (UIColor(hexString: "#abbaab"), UIColor(hexString: "#ffffff"))
    case .BetweenTheClouds:
      return (UIColor(hexString: "#73C8A9"), UIColor(hexString: "#373B44"))
    case .CrazyOrangeI:
      return (UIColor(hexString: "#D38312"), UIColor(hexString: "#A83279"))
    case .Hersheys:
      return (UIColor(hexString: "#1e130c"), UIColor(hexString: "#9a8478"))
    case .TalkingToMiceElf:
      return (UIColor(hexString: "#948E99"), UIColor(hexString: "#2E1437"))
    case .PurpleBliss:
      return (UIColor(hexString: "#360033"), UIColor(hexString: "#0b8793"))
    case .Predawn:
      return (UIColor(hexString: "#FFA17F"), UIColor(hexString: "#00223E"))
    case .EndlessRiver:
      return (UIColor(hexString: "#43cea2"), UIColor(hexString: "#185a9d"))
    case .PastelOrangeattheSun:
      return (UIColor(hexString: "#ffb347"), UIColor(hexString: "#ffcc33"))
    case .Twitch:
      return (UIColor(hexString: "#6441A5"), UIColor(hexString: "#2a0845"))
    case .Instagram:
      return (UIColor(hexString: "#517fa4"), UIColor(hexString: "#243949"))
    case .Flickr:
      return (UIColor(hexString: "#ff0084"), UIColor(hexString: "#33001b"))
    case .Vine:
      return (UIColor(hexString: "#00bf8f"), UIColor(hexString: "#001510"))
    case .Turquoiseflow:
      return (UIColor(hexString: "#136a8a"), UIColor(hexString: "#267871"))
    case .Portrait:
      return (UIColor(hexString: "#8e9eab"), UIColor(hexString: "#eef2f3"))
    case .VirginAmerica:
      return (UIColor(hexString: "#7b4397"), UIColor(hexString: "#dc2430"))
    case .KokoCaramel:
      return (UIColor(hexString: "#D1913C"), UIColor(hexString: "#FFD194"))
    case .FreshTurboscent:
      return (UIColor(hexString: "#F1F2B5"), UIColor(hexString: "#135058"))
    case .Greentodark:
      return (UIColor(hexString: "#6A9113"), UIColor(hexString: "#141517"))
    case .Ukraine:
      return (UIColor(hexString: "#004FF9"), UIColor(hexString: "#FFF94C"))
    case .Curiosityblue:
      return (UIColor(hexString: "#525252"), UIColor(hexString: "#3d72b4"))
    case .DarkKnight:
      return (UIColor(hexString: "#BA8B02"), UIColor(hexString: "#181818"))
    case .Piglet:
      return (UIColor(hexString: "#ee9ca7"), UIColor(hexString: "#ffdde1"))
    case .Lizard:
      return (UIColor(hexString: "#304352"), UIColor(hexString: "#d7d2cc"))
    case .SagePersuasion:
      return (UIColor(hexString: "#CCCCB2"), UIColor(hexString: "#757519"))
    case .BetweenNightandDay:
      return (UIColor(hexString: "#2c3e50"), UIColor(hexString: "#3498db"))
    case .Timber:
      return (UIColor(hexString: "#fc00ff"), UIColor(hexString: "#00dbde"))
    case .Passion:
      return (UIColor(hexString: "#e53935"), UIColor(hexString: "#e35d5b"))
    case .ClearSky:
      return (UIColor(hexString: "#005C97"), UIColor(hexString: "#363795"))
    case .MasterCard:
      return (UIColor(hexString: "#f46b45"), UIColor(hexString: "#eea849"))
    case .BackToEarth:
      return (UIColor(hexString: "#00C9FF"), UIColor(hexString: "#92FE9D"))
    case .DeepPurple:
      return (UIColor(hexString: "#673AB7"), UIColor(hexString: "#512DA8"))
    case .LittleLeaf:
      return (UIColor(hexString: "#76b852"), UIColor(hexString: "#8DC26F"))
    case .Netflix:
      return (UIColor(hexString: "#8E0E00"), UIColor(hexString: "#1F1C18"))
    case .LightOrange:
      return (UIColor(hexString: "#FFB75E"), UIColor(hexString: "#ED8F03"))
    case .GreenandBlue:
      return (UIColor(hexString: "#c2e59c"), UIColor(hexString: "#64b3f4"))
    case .Poncho:
      return (UIColor(hexString: "#403A3E"), UIColor(hexString: "#BE5869"))
    case .BacktotheFuture:
      return (UIColor(hexString: "#C02425"), UIColor(hexString: "#F0CB35"))
    case .Blush:
      return (UIColor(hexString: "#B24592"), UIColor(hexString: "#F15F79"))
    case .Inbox:
      return (UIColor(hexString: "#457fca"), UIColor(hexString: "#5691c8"))
    case .Purplin:
      return (UIColor(hexString: "#6a3093"), UIColor(hexString: "#a044ff"))
    case .PaleWood:
      return (UIColor(hexString: "#eacda3"), UIColor(hexString: "#d6ae7b"))
    case .Haikus:
      return (UIColor(hexString: "#fd746c"), UIColor(hexString: "#ff9068"))
    case .Pizelex:
      return (UIColor(hexString: "#114357"), UIColor(hexString: "#F29492"))
    case .Joomla:
      return (UIColor(hexString: "#1e3c72"), UIColor(hexString: "#2a5298"))
    case .Christmas:
      return (UIColor(hexString: "#2F7336"), UIColor(hexString: "#AA3A38"))
    case .MinnesotaVikings:
      return (UIColor(hexString: "#5614B0"), UIColor(hexString: "#DBD65C"))
    case .MiamiDolphins:
      return (UIColor(hexString: "#4DA0B0"), UIColor(hexString: "#D39D38"))
    case .Forest:
      return (UIColor(hexString: "#5A3F37"), UIColor(hexString: "#2C7744"))
    case .Nighthawk:
      return (UIColor(hexString: "#2980b9"), UIColor(hexString: "#2c3e50"))
    case .Superman:
      return (UIColor(hexString: "#0099F7"), UIColor(hexString: "#F11712"))
    case .Suzy:
      return (UIColor(hexString: "#834d9b"), UIColor(hexString: "#d04ed6"))
    case .DarkSkies:
      return (UIColor(hexString: "#4B79A1"), UIColor(hexString: "#283E51"))
    }
  }
}

private class GradientView: UIView {

  let viewTag = 999
  
  // MARK: - Life cycle
  
  init(frame: CGRect, layer: CAGradientLayer) {
    super.init(frame: frame)
    tag = viewTag
    self.layer.insertSublayer(layer, atIndex: 0)
    autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class func layerClass() -> AnyClass {
    return CAGradientLayer.self
  }
  
}