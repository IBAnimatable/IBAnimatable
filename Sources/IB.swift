//
//  IB.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 17/01/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import Foundation

private struct AssociatedKeys {
  static var ib = "IBAnimatable"
}

public final class IB: NSObject, CornerDesignable {

  let view: UIView

  init(view: UIView) {
    self.view = view
    super.init()
  }

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
