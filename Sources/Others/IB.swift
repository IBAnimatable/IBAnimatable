//
//  IB.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 17/01/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import Foundation

public final class IB: NSObject, CornerDesignable, FillDesignable, BorderDesignable,
                       RotationDesignable, ShadowDesignable {

  private let view: UIView

  // MARK: Life cycle

  fileprivate init(view: UIView) {
    self.view = view
    super.init()
  }

  public func reload() {
    configureCornerRadius(in: view)
    configureBorder(in: view)
    configureMaskShadow(in: view)
  }

  // MARK: - CornerDesignable

  public var cornerRadius: CGFloat = CGFloat.nan {
    didSet {
      configureCornerRadius(in: view)
    }
  }

  public var cornerSides: CornerSides  = .allSides {
    didSet {
      configureCornerRadius(in: view)
    }
  }

  // MARK: - FillDesignable

  public var fillColor: UIColor? {
    didSet {
      configureFillColor(in: view)
    }
  }

  public var predefinedColor: ColorType? {
    didSet {
      configureFillColor(in: view)
    }
  }

  public var opacity: CGFloat = CGFloat.nan {
    didSet {
      configureOpacity(in: view)
    }
  }

  // MARK: - BorderDesignable

  public var borderType: BorderType  = .solid {
    didSet {
      configureBorder(in: view)
    }
  }

  public var borderColor: UIColor? {
    didSet {
      configureBorder(in: view)
    }
  }

  public var borderWidth: CGFloat = CGFloat.nan {
    didSet {
      configureBorder(in: view)
    }
  }

  public var borderSides: BorderSides  = .AllSides {
    didSet {
      configureBorder(in: view)
    }
  }

  // MARK: - RotationDesignable

  public var rotate: CGFloat = CGFloat.nan {
    didSet {
      configureRotate(in: view)
    }
  }

  // MARK: - ShadowDesignable

  public var shadowColor: UIColor? {
    didSet {
      configureShadowColor(in: view)
    }
  }

  public var shadowRadius: CGFloat = CGFloat.nan {
    didSet {
      configureShadowRadius(in: view)
    }
  }

  public var shadowOpacity: CGFloat = CGFloat.nan {
    didSet {
      configureShadowOpacity(in: view)
    }
  }

  public var shadowOffset: CGPoint = CGPoint(x: CGFloat.nan, y: CGFloat.nan) {
    didSet {
      configureShadowOffset(in: view)
    }
  }

}

// MARK: -

private struct AssociatedKeys {
  static var ib = "IBAnimatable"
}

extension UIView {

  public var ib: IB {
    get {
      var ibValue = objc_getAssociatedObject(self, &AssociatedKeys.ib) as? IB
      if ibValue == nil {
        ibValue = IB(view: self)
        self.ib = ibValue!
      }
      return ibValue!
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKeys.ib, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

}
