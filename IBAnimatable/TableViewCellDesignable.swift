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
      if responds(to: #selector(setter: UITableViewCell.separatorInset)) {
        separatorInset = UIEdgeInsetsZero
      }
      
      if responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
        preservesSuperviewLayoutMargins = false
      }
      
      if responds(to: #selector(setter: UIView.layoutMargins)) {
        layoutMargins = UIEdgeInsetsZero
      }
    }
  }
}
