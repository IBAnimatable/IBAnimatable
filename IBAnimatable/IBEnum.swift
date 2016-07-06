//
//  Created by jason akakpo on 27/06/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 A protocol provides extension method for converting `String` into `enum`.
 Because `@IBInspectable` property can not support `enum` directly. To provide both `enum` API in code and `@IBInspectable` supported type `String` in Interface Builder, we use `IBEnum` to bridge Swift `enum` and `String`
 */
public protocol IBEnum: StringLiteralConvertible {
  /**
   Initializes a swift `enum` with provided optional string
   
   - Parameter string: The optional string to be converted into `enum`.
   */
  init(string: String?)
}

public extension IBEnum {
  /**
   Helper function that returns a tuple containing the name and params from a string `string`
   
   - Parameter from string: The string to be converted into `enum`.
    - Discussion: the string format is like "enumName(param1,param2,param3)"
   - Returns: A tuple containing the name and an array of parameter string
   */
   static func extractNameAndParams(from string: String) -> (name: String, params: [String]) {
    let tokens = string.components(separatedBy: CharacterSet(charactersIn: "()")).filter({!$0.isEmpty})
    let name = tokens.first ?? ""
    let paramsString = tokens.count >= 2 ? tokens[1] : ""
    let params = paramsString.components(separatedBy: ",").filter({!$0.isEmpty})
    return (name:name, params:params)
  }
}

// MARK: - StringLiteralConvertible
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
