//
//  Created by Jake Lin on 12/10/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class DesignableNavigationBar: UINavigationBar, NavigationBarDesignable {
  @IBInspectable public var solidColor: Bool = false
  
  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configInspectableProperties()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    configInspectableProperties()
  }
  
  // MARK: - Private
  private func configInspectableProperties() {
    configNavigationBar()
  }
}
