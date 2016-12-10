//: ## Common code

import UIKit
import IBAnimatable

//: Constants
public let iPhoneWidth = 375
public let iPhoneHeight = 667
public let animatableViewWidth = 100
public let animatableViewX = (iPhoneWidth - animatableViewWidth) / 2
public let animatableViewY = (iPhoneHeight - animatableViewWidth) / 2

//: Phone View
public class PhoneView: UIView {
  public init() {
    let frame = CGRect(x: 0, y: 0, width: iPhoneWidth, height: iPhoneHeight)
    super.init(frame: frame)
    backgroundColor = .white
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
  }

  public required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//: Circle View subclassed from `AnimatableView`
public class CircleView: AnimatableView {
  public init() {
    let frame = CGRect(x: animatableViewX, y: animatableViewY, width: animatableViewWidth, height: animatableViewWidth)
    super.init(frame: frame)

    configureAnimatableProperties()
    fillColor = #colorLiteral(red: 0.7098039216, green: 0.4549019608, blue: 0.9607843137, alpha: 1)
    borderWidth = 2
    borderColor = .purple
    maskType = .circle
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
