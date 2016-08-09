//
//  Created by Jake Lin on 12/4/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol GradientDesignable {
  var startColor: UIColor? { get set }
  var endColor: UIColor? { get set }
  var predefinedGradient: GradientType? { get set }
  var startPoint: GradientStartPoint { get set }
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
    
    let gradientStartPoint = startPoint
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
  
  private func configPredefinedGradient() -> GradientColor? {
    
    guard let gradientType = predefinedGradient else {
        return nil
    }
    return gradientType.colors
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
  
   class func layerClass() -> AnyClass {
    return CAGradientLayer.self
  }
  
}
