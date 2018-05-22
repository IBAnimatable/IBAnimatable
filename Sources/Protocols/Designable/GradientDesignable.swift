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
    case .conical:
      return makeConicalLayer(colors: colors)
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

    layer.startPoint = startPoint.startPoint
    layer.endPoint = startPoint.endPoint
    return layer
  }

  private func makeRadialLayer(colors: [CGColor]) -> RadialGradientLayer {
    let layer = RadialGradientLayer()
    layer.colors = colors

    layer.startPoint = startPoint.startPoint
    layer.endPoint = startPoint.endPoint
    return layer
  }

  private func makeConicalLayer(colors: [CGColor]) -> ConicalGradientLayer {
    let layer = ConicalGradientLayer()
    layer.colors = colors

    layer.startPoint = startPoint.startPoint
    layer.endPoint = startPoint.endPoint
    return layer
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
