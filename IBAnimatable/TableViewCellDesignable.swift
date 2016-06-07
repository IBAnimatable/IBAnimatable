//
//  Created by Jake Lin on 12/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol TableViewCellDesignable {
  var removeSeparatorMargins: Bool { get set }
}

public extension TableViewCellDesignable where Self: UITableViewCell {
  public func configSeparatorMargins() {
    if removeSeparatorMargins {
      if respondsToSelector(Selector("setSeparatorInset:")) {
        separatorInset = UIEdgeInsetsZero
      }
      
      if respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:")) {
        preservesSuperviewLayoutMargins = false
      }
      
      if respondsToSelector(Selector("setLayoutMargins:")) {
        layoutMargins = UIEdgeInsetsZero
      }
    }
  }
}
