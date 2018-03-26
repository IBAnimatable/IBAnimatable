//
//  Created by Jake Lin on 12/4/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol GradientDesignable: class {
  var gradientMode: GradientMode { get set }
  var startColor: UIColor? { get set }
  var endColor: UIColor? { get set }
  var predefinedGradient: GradientType? { get set }
  var startPoint: GradientStartPoint { get set }
}

// MARK: - UIView

extension GradientDesignable where Self: UIView {

  public func configureGradient() {
    configureGradient(in: self)
  }

}

// MARK: - NavigationBar

extension GradientDesignable where Self: UINavigationBar {

  public func configureGradient() {
    let navBarFrame = CGRect(x: 0, y: 0, width: bounds.width, height: UIApplication.shared.statusBarFrame.height)
    let gradientLayer = makeGradientLayer()
    gradientLayer?.frame = navBarFrame
    gradientLayer?.cornerRadius = layer.cornerRadius

    let image = gradientLayer?.makeImage()
    setBackgroundImage(image, for: .default)
  }

}

// MARK: - Layers

extension CALayer {

  fileprivate func makeImage() -> UIImage? {
    UIGraphicsBeginImageContext(frame.size)
    render(in: UIGraphicsGetCurrentContext()!)
    let outputImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return outputImage
  }

}

// MARK: - Common

extension GradientDesignable {

  func configureGradient(in view: UIView) {
    view.subviews.filter { $0 is PrivateGradientView }.forEach {
      $0.removeFromSuperview()
    }

    guard let gradientLayer = makeGradientLayer() else {
      return
    }

    gradientLayer.cornerRadius = view.layer.cornerRadius
    gradientLayer.frame = view.bounds
    let gradientView = PrivateGradientView(frame: view.bounds, gradientLayer: gradientLayer)
    view.insertSubview(gradientView, at: 0)
  }

  private func makeGradientLayer() -> CALayer? {
    guard let colors = gradientColors() else {
      return nil
    }

    switch gradientMode {
    case .linear:
      return makeLinearLayer(colors: colors)
    case .radial:
      return makeRadialLayer(colors: colors)
    }
  }

  private func gradientColors() -> [CGColor]? {
    if let startColor = startColor, let endColor = endColor {
      return [startColor.cgColor, endColor.cgColor]
    } else if let startColor = predefinedGradient?.colors.start, let endColor = predefinedGradient?.colors.end {
      return [startColor.cgColor, endColor.cgColor]
    }
    return nil
  }

  private func makeLinearLayer(colors: [CGColor]) -> CAGradientLayer {
    let layer = CAGradientLayer()
    layer.colors = colors

    let points = gradientPoints()
    layer.startPoint = points.0
    layer.endPoint = points.1
    return layer
  }

  private func makeRadialLayer(colors: [CGColor]) -> RadialGradientLayer {
    let layer = RadialGradientLayer()
    layer.colors = colors

    let points = gradientPoints()
    layer.startPoint = points.0
    layer.endPoint = points.1
    return layer
  }

  private func gradientPoints() -> (CGPoint, CGPoint) {
    switch startPoint {
    case .top:
      return (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1))
    case .topRight:
      return (CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1))
    case .right:
      return (CGPoint(x: 1, y: 0.5), CGPoint(x: 0, y: 0.5))
    case .bottomRight:
      return (CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 0))
    case .bottom:
      return (CGPoint(x: 0.5, y: 1), CGPoint(x: 0.5, y: 0))
    case .bottomLeft:
      return (CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0))
    case .left:
      return (CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5))
    case .topLeft:
      return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
    case let .custom(start, end):
      return (CGPoint(x: start.x, y: start.y), CGPoint(x: end.x, y: end.y))
    case .none:
      return (.zero, .zero)
    }
  }

}

// MARK: - PrivateGradientView

private class PrivateGradientView: UIView {

  init(frame: CGRect, gradientLayer: CALayer) {
    super.init(frame: frame)
    layer.insertSublayer(gradientLayer, at: 0)
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override class var layerClass: AnyClass {
    return CALayer.self
  }

}
