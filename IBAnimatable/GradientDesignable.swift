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
    if let unwrappedStartColor = startColor, let unwrappedEndColor = endColor {
      configGradientWithStartColor(unwrappedStartColor, endColor: unwrappedEndColor)
    } else if let unwrappedStartColor = predefinedGradient?.0, let unwrappedEndColor = predefinedGradient?.1 {
      configGradientWithStartColor(unwrappedStartColor, endColor: unwrappedEndColor)
    }
  }

  private func configGradientWithStartColor(_ startColor: UIColor, endColor: UIColor) {
    // Default value is `.Top`
    var gradientStartPoint: GradientStartPoint = .top
    if let unwrappedStartPoint = startPoint, let resolvedGradientStartPoint = GradientStartPoint(rawValue: unwrappedStartPoint) {
      gradientStartPoint = resolvedGradientStartPoint
    }
    
    let gradientLayer = createGradientLayer()
    gradientLayer.colors = [startColor.cgColor, endColor.cgColor]    
    switch gradientStartPoint {
    case .top:
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    case .topRight:
      gradientLayer.startPoint = CGPoint(x: 1, y: 0)
      gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    case .right:
      gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
    case .bottomRight:
      gradientLayer.startPoint = CGPoint(x: 1, y: 1)
      gradientLayer.endPoint = CGPoint(x: 0, y: 0)
    case .bottom:
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
    case .bottomLeft:
      gradientLayer.startPoint = CGPoint(x: 0, y: 1)
      gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    case .left:
      gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    case .topLeft:
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
    
    let gradientView = GradientView(frame: bounds, layer: gradientLayer)
    let oldGradientView = viewWithTag(gradientView.tag)
    oldGradientView?.removeFromSuperview()
    self.insertSubview(gradientView, at: 0)
  }
  
  private func createGradientLayer() -> CAGradientLayer {
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    return gradientLayer
  }
  
  private func configPredefinedGradient() -> (UIColor, UIColor)? {
    guard let unwrappedGradientTypeString = predefinedGradient, let gradientType = GradientType(rawValue: unwrappedGradientTypeString) else {
        return nil
    }
    
    switch gradientType {
    case .sunnyDays:
      return (UIColor(hexString: "#EDE574"), UIColor(hexString: "#E1F5C4"))
    case .greenBeach:
      return (UIColor(hexString: "#02AAB0"), UIColor(hexString: "#00CDAC"))
    case .intuitivePurple:
      return (UIColor(hexString: "#DA22FF"), UIColor(hexString: "#9733EE"))
    case .emeraldWater:
      return (UIColor(hexString: "#348F50"), UIColor(hexString: "#56B4D3"))
    case .lemonTwist:
      return (UIColor(hexString: "#3CA55C"), UIColor(hexString: "#B5AC49"))
    case .horizon:
      return (UIColor(hexString: "#003973"), UIColor(hexString: "#E5E5BE"))
    case .roseWater:
      return (UIColor(hexString: "#E55D87"), UIColor(hexString: "#5FC3E4"))
    case .frozen:
      return (UIColor(hexString: "#403B4A"), UIColor(hexString: "#E7E9BB"))
    case .mangoPulp:
      return (UIColor(hexString: "#F09819"), UIColor(hexString: "#EDDE5D"))
    case .bloodyMary:
      return (UIColor(hexString: "#FF512F"), UIColor(hexString: "#DD2476"))
    case .aubergine:
      return (UIColor(hexString: "#AA076B"), UIColor(hexString: "#61045F"))
    case .aquaMarine:
      return (UIColor(hexString: "#1A2980"), UIColor(hexString: "#26D0CE"))
    case .sunrise:
      return (UIColor(hexString: "#FF512F"), UIColor(hexString: "#F09819"))
    case .purpleParadise:
      return (UIColor(hexString: "#1D2B64"), UIColor(hexString: "#F8CDDA"))
    case .seaWeed:
      return (UIColor(hexString: "#4CB8C4"), UIColor(hexString: "#3CD3AD"))
    case .pinky:
      return (UIColor(hexString: "#DD5E89"), UIColor(hexString: "#F7BB97"))
    case .cherry:
      return (UIColor(hexString: "#EB3349"), UIColor(hexString: "#F45C43"))
    case .mojito:
      return (UIColor(hexString: "#1D976C"), UIColor(hexString: "#93F9B9"))
    case .juicyOrange:
      return (UIColor(hexString: "#FF8008"), UIColor(hexString: "#FFC837"))
    case .mirage:
      return (UIColor(hexString: "#16222A"), UIColor(hexString: "#3A6073"))
    case .steelGray:
      return (UIColor(hexString: "#1F1C2C"), UIColor(hexString: "#928DAB"))
    case .kashmir:
      return (UIColor(hexString: "#614385"), UIColor(hexString: "#516395"))
    case .electricViolet:
      return (UIColor(hexString: "#4776E6"), UIColor(hexString: "#8E54E9"))
    case .veniceBlue:
      return (UIColor(hexString: "#085078"), UIColor(hexString: "#85D8CE"))
    case .boraBora:
      return (UIColor(hexString: "#2BC0E4"), UIColor(hexString: "#EAECC6"))
    case .moss:
      return (UIColor(hexString: "#134E5E"), UIColor(hexString: "#71B280"))
    case .shroomHaze:
      return (UIColor(hexString: "#5C258D"), UIColor(hexString: "#4389A2"))
    case .mystic:
      return (UIColor(hexString: "#757F9A"), UIColor(hexString: "#D7DDE8"))
    case .midnightCity:
      return (UIColor(hexString: "#232526"), UIColor(hexString: "#414345"))
    case .seaBlizz:
      return (UIColor(hexString: "#1CD8D2"), UIColor(hexString: "#93EDC7"))
    case .opa:
      return (UIColor(hexString: "#3D7EAA"), UIColor(hexString: "#FFE47A"))
    case .titanium:
      return (UIColor(hexString: "#283048"), UIColor(hexString: "#859398"))
    case .mantle:
      return (UIColor(hexString: "#24C6DC"), UIColor(hexString: "#514A9D"))
    case .dracula:
      return (UIColor(hexString: "#DC2424"), UIColor(hexString: "#4A569D"))
    case .peach:
      return (UIColor(hexString: "#ED4264"), UIColor(hexString: "#FFEDBC"))
    case .moonrise:
      return (UIColor(hexString: "#DAE2F8"), UIColor(hexString: "#D6A4A4"))
    case .clouds:
      return (UIColor(hexString: "#ECE9E6"), UIColor(hexString: "#FFFFFF"))
    case .stellar:
      return (UIColor(hexString: "#7474BF"), UIColor(hexString: "#348AC7"))
    case .bourbon:
      return (UIColor(hexString: "#EC6F66"), UIColor(hexString: "#F3A183"))
    case .calmDarya:
      return (UIColor(hexString: "#5f2c82"), UIColor(hexString: "#49a09d"))
    case .influenza:
      return (UIColor(hexString: "#C04848"), UIColor(hexString: "#480048"))
    case .shrimpy:
      return (UIColor(hexString: "#e43a15"), UIColor(hexString: "#e65245"))
    case .army:
      return (UIColor(hexString: "#414d0b"), UIColor(hexString: "#727a17"))
    case .miaka:
      return (UIColor(hexString: "#FC354C"), UIColor(hexString: "#0ABFBC"))
    case .pinotNoir:
      return (UIColor(hexString: "#4b6cb7"), UIColor(hexString: "#182848"))
    case .dayTripper:
      return (UIColor(hexString: "#f857a6"), UIColor(hexString: "#ff5858"))
    case .namn:
      return (UIColor(hexString: "#a73737"), UIColor(hexString: "#7a2828"))
    case .blurryBeach:
      return (UIColor(hexString: "#d53369"), UIColor(hexString: "#cbad6d"))
    case .vasily:
      return (UIColor(hexString: "#e9d362"), UIColor(hexString: "#333333"))
    case .aLostMemory:
      return (UIColor(hexString: "#DE6262"), UIColor(hexString: "#FFB88C"))
    case .petrichor:
      return (UIColor(hexString: "#666600"), UIColor(hexString: "#999966"))
    case .jonquil:
      return (UIColor(hexString: "#FFEEEE"), UIColor(hexString: "#DDEFBB"))
    case .siriusTamed:
      return (UIColor(hexString: "#EFEFBB"), UIColor(hexString: "#D4D3DD"))
    case .kyoto:
      return (UIColor(hexString: "#c21500"), UIColor(hexString: "#ffc500"))
    case .mistyMeadow:
      return (UIColor(hexString: "#215f00"), UIColor(hexString: "#e4e4d9"))
    case .aqualicious:
      return (UIColor(hexString: "#50C9C3"), UIColor(hexString: "#96DEDA"))
    case .moor:
      return (UIColor(hexString: "#616161"), UIColor(hexString: "#9bc5c3"))
    case .almost:
      return (UIColor(hexString: "#ddd6f3"), UIColor(hexString: "#faaca8"))
    case .foreverLost:
      return (UIColor(hexString: "#5D4157"), UIColor(hexString: "#A8CABA"))
    case .winter:
      return (UIColor(hexString: "#E6DADA"), UIColor(hexString: "#274046"))
    case .autumn:
      return (UIColor(hexString: "#DAD299"), UIColor(hexString: "#B0DAB9"))
    case .candy:
      return (UIColor(hexString: "#D3959B"), UIColor(hexString: "#BFE6BA"))
    case .reef:
      return (UIColor(hexString: "#00d2ff"), UIColor(hexString: "#3a7bd5"))
    case .theStrain:
      return (UIColor(hexString: "#870000"), UIColor(hexString: "#190A05"))
    case .dirtyFog:
      return (UIColor(hexString: "#B993D6"), UIColor(hexString: "#8CA6DB"))
    case .earthly:
      return (UIColor(hexString: "#649173"), UIColor(hexString: "#DBD5A4"))
    case .virgin:
      return (UIColor(hexString: "#C9FFBF"), UIColor(hexString: "#FFAFBD"))
    case .ash:
      return (UIColor(hexString: "#606c88"), UIColor(hexString: "#3f4c6b"))
    case .shadowNight:
      return (UIColor(hexString: "#000000"), UIColor(hexString: "#53346D"))
    case .cherryblossoms:
      return (UIColor(hexString: "#FBD3E9"), UIColor(hexString: "#BB377D"))
    case .parklife:
      return (UIColor(hexString: "#ADD100"), UIColor(hexString: "#7B920A"))
    case .danceToForget:
      return (UIColor(hexString: "#FF4E50"), UIColor(hexString: "#F9D423"))
    case .starfall:
      return (UIColor(hexString: "#F0C27B"), UIColor(hexString: "#4B1248"))
    case .redMist:
      return (UIColor(hexString: "#000000"), UIColor(hexString: "#e74c3c"))
    case .tealLove:
      return (UIColor(hexString: "#AAFFA9"), UIColor(hexString: "#11FFBD"))
    case .neonLife:
      return (UIColor(hexString: "#B3FFAB"), UIColor(hexString: "#12FFF7"))
    case .manOfSteel:
      return (UIColor(hexString: "#780206"), UIColor(hexString: "#061161"))
    case .amethyst:
      return (UIColor(hexString: "#9D50BB"), UIColor(hexString: "#6E48AA"))
    case .cheerUpEmoKid:
      return (UIColor(hexString: "#556270"), UIColor(hexString: "#FF6B6B"))
    case .shore:
      return (UIColor(hexString: "#70e1f5"), UIColor(hexString: "#ffd194"))
    case .facebookMessenger:
      return (UIColor(hexString: "#00c6ff"), UIColor(hexString: "#0072ff"))
    case .soundCloud:
      return (UIColor(hexString: "#fe8c00"), UIColor(hexString: "#f83600"))
    case .behongo:
      return (UIColor(hexString: "#52c234"), UIColor(hexString: "#061700"))
    case .servQuick:
      return (UIColor(hexString: "#485563"), UIColor(hexString: "#29323c"))
    case .friday:
      return (UIColor(hexString: "#83a4d4"), UIColor(hexString: "#b6fbff"))
    case .martini:
      return (UIColor(hexString: "#FDFC47"), UIColor(hexString: "#24FE41"))
    case .metallicToad:
      return (UIColor(hexString: "#abbaab"), UIColor(hexString: "#ffffff"))
    case .betweenTheClouds:
      return (UIColor(hexString: "#73C8A9"), UIColor(hexString: "#373B44"))
    case .crazyOrangeI:
      return (UIColor(hexString: "#D38312"), UIColor(hexString: "#A83279"))
    case .hersheys:
      return (UIColor(hexString: "#1e130c"), UIColor(hexString: "#9a8478"))
    case .talkingToMiceElf:
      return (UIColor(hexString: "#948E99"), UIColor(hexString: "#2E1437"))
    case .purpleBliss:
      return (UIColor(hexString: "#360033"), UIColor(hexString: "#0b8793"))
    case .predawn:
      return (UIColor(hexString: "#FFA17F"), UIColor(hexString: "#00223E"))
    case .endlessRiver:
      return (UIColor(hexString: "#43cea2"), UIColor(hexString: "#185a9d"))
    case .pastelOrangeattheSun:
      return (UIColor(hexString: "#ffb347"), UIColor(hexString: "#ffcc33"))
    case .twitch:
      return (UIColor(hexString: "#6441A5"), UIColor(hexString: "#2a0845"))
    case .instagram:
      return (UIColor(hexString: "#517fa4"), UIColor(hexString: "#243949"))
    case .flickr:
      return (UIColor(hexString: "#ff0084"), UIColor(hexString: "#33001b"))
    case .vine:
      return (UIColor(hexString: "#00bf8f"), UIColor(hexString: "#001510"))
    case .turquoiseflow:
      return (UIColor(hexString: "#136a8a"), UIColor(hexString: "#267871"))
    case .portrait:
      return (UIColor(hexString: "#8e9eab"), UIColor(hexString: "#eef2f3"))
    case .virginAmerica:
      return (UIColor(hexString: "#7b4397"), UIColor(hexString: "#dc2430"))
    case .kokoCaramel:
      return (UIColor(hexString: "#D1913C"), UIColor(hexString: "#FFD194"))
    case .freshTurboscent:
      return (UIColor(hexString: "#F1F2B5"), UIColor(hexString: "#135058"))
    case .greenToDark:
      return (UIColor(hexString: "#6A9113"), UIColor(hexString: "#141517"))
    case .ukraine:
      return (UIColor(hexString: "#004FF9"), UIColor(hexString: "#FFF94C"))
    case .curiosityBlue:
      return (UIColor(hexString: "#525252"), UIColor(hexString: "#3d72b4"))
    case .darkKnight:
      return (UIColor(hexString: "#BA8B02"), UIColor(hexString: "#181818"))
    case .piglet:
      return (UIColor(hexString: "#ee9ca7"), UIColor(hexString: "#ffdde1"))
    case .lizard:
      return (UIColor(hexString: "#304352"), UIColor(hexString: "#d7d2cc"))
    case .sagePersuasion:
      return (UIColor(hexString: "#CCCCB2"), UIColor(hexString: "#757519"))
    case .betweenNightandDay:
      return (UIColor(hexString: "#2c3e50"), UIColor(hexString: "#3498db"))
    case .timber:
      return (UIColor(hexString: "#fc00ff"), UIColor(hexString: "#00dbde"))
    case .passion:
      return (UIColor(hexString: "#e53935"), UIColor(hexString: "#e35d5b"))
    case .clearSky:
      return (UIColor(hexString: "#005C97"), UIColor(hexString: "#363795"))
    case .masterCard:
      return (UIColor(hexString: "#f46b45"), UIColor(hexString: "#eea849"))
    case .backToEarth:
      return (UIColor(hexString: "#00C9FF"), UIColor(hexString: "#92FE9D"))
    case .deepPurple:
      return (UIColor(hexString: "#673AB7"), UIColor(hexString: "#512DA8"))
    case .littleLeaf:
      return (UIColor(hexString: "#76b852"), UIColor(hexString: "#8DC26F"))
    case .netflix:
      return (UIColor(hexString: "#8E0E00"), UIColor(hexString: "#1F1C18"))
    case .lightOrange:
      return (UIColor(hexString: "#FFB75E"), UIColor(hexString: "#ED8F03"))
    case .greenAndBlue:
      return (UIColor(hexString: "#c2e59c"), UIColor(hexString: "#64b3f4"))
    case .poncho:
      return (UIColor(hexString: "#403A3E"), UIColor(hexString: "#BE5869"))
    case .backToTheFuture:
      return (UIColor(hexString: "#C02425"), UIColor(hexString: "#F0CB35"))
    case .blush:
      return (UIColor(hexString: "#B24592"), UIColor(hexString: "#F15F79"))
    case .inbox:
      return (UIColor(hexString: "#457fca"), UIColor(hexString: "#5691c8"))
    case .purplin:
      return (UIColor(hexString: "#6a3093"), UIColor(hexString: "#a044ff"))
    case .paleWood:
      return (UIColor(hexString: "#eacda3"), UIColor(hexString: "#d6ae7b"))
    case .haikus:
      return (UIColor(hexString: "#fd746c"), UIColor(hexString: "#ff9068"))
    case .pizelex:
      return (UIColor(hexString: "#114357"), UIColor(hexString: "#F29492"))
    case .joomla:
      return (UIColor(hexString: "#1e3c72"), UIColor(hexString: "#2a5298"))
    case .christmas:
      return (UIColor(hexString: "#2F7336"), UIColor(hexString: "#AA3A38"))
    case .minnesotaVikings:
      return (UIColor(hexString: "#5614B0"), UIColor(hexString: "#DBD65C"))
    case .miamiDolphins:
      return (UIColor(hexString: "#4DA0B0"), UIColor(hexString: "#D39D38"))
    case .forest:
      return (UIColor(hexString: "#5A3F37"), UIColor(hexString: "#2C7744"))
    case .nighthawk:
      return (UIColor(hexString: "#2980b9"), UIColor(hexString: "#2c3e50"))
    case .superman:
      return (UIColor(hexString: "#0099F7"), UIColor(hexString: "#F11712"))
    case .suzy:
      return (UIColor(hexString: "#834d9b"), UIColor(hexString: "#d04ed6"))
    case .darkSkies:
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
    self.layer.insertSublayer(layer, at: 0)
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class func layerClass() -> AnyClass {
    return CAGradientLayer.self
  }
  
}
