//
//  IB.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 17/01/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import Foundation

public final class IB: NSObject, CornerDesignable, FillDesignable {

  let view: UIView

  init(view: UIView) {
    self.view = view
    super.init()
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
