//
//  Created by Jake Lin on 12/10/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable open class DesignableNavigationBar: UINavigationBar, NavigationBarDesignable {
  @IBInspectable open var solidColor: Bool = false
  
  // MARK: - Lifecycle
  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configureInspectableProperties()
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    configureInspectableProperties()
  }
  
  // MARK: - Private
  fileprivate func configureInspectableProperties() {
    configureNavigationBar()
  }
}
