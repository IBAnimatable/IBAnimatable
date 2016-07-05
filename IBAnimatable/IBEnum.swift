//
//  Created by jason akakpo on 27/06/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation


public protocol IBEnum: StringLiteralConvertible {
  init(string: String?)
}

public extension IBEnum {
  
  /// Helper function that returns a tuple containing the name and params
  ///
  ///
  /// - Discussion
  /// Since "name(param1,param2,param3)" is the classic IBAnimatable format
  ///
  /// this method will return "wave"
  static func extractNameAndParams(from string: String) -> (name: String, params: [String]) {
    let tokens = string.components(separatedBy: CharacterSet(charactersIn: "()")).filter({!$0.isEmpty}) // extract params list   self.enumName
    let maskName = tokens.first ?? ""
    let paramsString = tokens.count >= 2 ? tokens[1] : ""
    let params = paramsString.components(separatedBy: ",").filter({!$0.isEmpty}) // params list
    return (name:maskName, params:params)
  }
  
}


 public extension IBEnum {
  init(stringLiteral value: String) {
    self.init(string:value)
  }
  
  init(unicodeScalarLiteral value: String) {
    self.init(string:value)

  }
  
  init(extendedGraphemeClusterLiteral value: String) {
    self.init(string:value)
  }

}
