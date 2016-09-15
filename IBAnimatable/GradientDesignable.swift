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
  public func configureGradient() {
    let predefinedGradient = configurePredefinedGradient()
    if let startColor = startColor, let endColor = endColor {
      configureGradient(startColor: startColor, endColor: endColor)
    } else if let startColor = predefinedGradient?.start, let endColor = predefinedGradient?.end {
      configureGradient(startColor: startColor, endColor: endColor)
    }
  }
}

fileprivate extension GradientDesignable where Self: UIView {
  func configureGradient(startColor: UIColor, endColor: UIColor) {
    // Default value is `.Top`
    
    let gradientStartPoint = startPoint
    let gradientLayer = makeGradientLayer()
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
    
    subviews.filter { $0 is PrivateGradientView }.forEach {
      $0.removeFromSuperview()
    }
    
    let gradientView = PrivateGradientView(frame: bounds, layer: gradientLayer)
    insertSubview(gradientView, at: 0)
  }
  
  func makeGradientLayer() -> CAGradientLayer {
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.cornerRadius = layer.cornerRadius
    return gradientLayer
  }
  
  func configurePredefinedGradient() -> GradientColor? {
    
    guard let gradientType = predefinedGradient else {
      return nil
    }
    return gradientType.colors
  }
}

private class PrivateGradientView: UIView {
  // MARK: - Life cycle
  
  init(frame: CGRect, layer: CAGradientLayer) {
    super.init(frame: frame)
    self.layer.insertSublayer(layer, at: 0)
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
  
}
