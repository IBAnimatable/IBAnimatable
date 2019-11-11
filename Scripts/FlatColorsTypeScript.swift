// swiftlint:disable:next operator_usage_whitespace
#!/usr/bin/swift

import Foundation
import UIKit

let colorsTypeURL = "https://gist.githubusercontent.com/tkrugg/a577c32e93eecc6c7991/raw/f7866132e26f9bffcda9caf13dced55e4a99e145/flatuicolors.json"

func JSON(_ urlToRequest: String) -> Data {
  guard let data = try? Data(contentsOf: URL(string: urlToRequest)!) else {
    fatalError("URL Request failed")
  }
  return data
}

func parseJSON(JSONData: Data) -> [String: String]? {
  var json: [String: String]?
  do {
    json = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as? [String: String]
    return json
  } catch {
    print("JSON serialization did fail")
    return nil
  }
}

func colorLiteral(r: Int, g: Int, b: Int, a: Double) -> String {
  return "#colorLiteral(red: \(CGFloat(r) / 255), green: \(CGFloat(g) / 255), blue: \(CGFloat(b) / 255), alpha: \(a))"
}

// Generator constants
let enumCase = "\tcase %@\n"
let switchCase = "case .%@:\n"
let color =  "\treturn %@ \n"
let endEnumOrSwitch = "}"

// Finale string
var enumColorType = "public enum ColorType: String {\n"
var switchColorType = "switch colorType {\n"

// Enum generator
let colorsType: Dictionary? = parseJSON(JSONData: JSON(colorsTypeURL))

// Parsing
if let colorsType = colorsType {
  for colorName in colorsType.keys {
    // swiftlint:disable:next for_where
    if var rgbColors = colorsType[colorName] {
      var finalName = colorName.capitalized(with: NSLocale.current)
      finalName = finalName.replacingOccurrences(of: "-", with: "")
      finalName = "flat" + finalName
      enumColorType += String(format: enumCase, finalName)
      switchColorType += String(format: switchCase, finalName)

      rgbColors = rgbColors.replacingOccurrences(of: "rgba(", with: "")
      rgbColors = rgbColors.replacingOccurrences(of: ")", with: "")
      rgbColors = rgbColors.replacingOccurrences(of: " ", with: "")
      let colors = rgbColors.components(separatedBy: ",")
      switchColorType += String(format: color, colorLiteral(r: Int(colors[0])!, g: Int(colors[1])!, b: Int(colors[2])!, a: Double(colors[3])!))
    }
  }

  enumColorType += endEnumOrSwitch
  switchColorType += endEnumOrSwitch
  print(enumColorType)
  print("\n")
  print(switchColorType)
}
