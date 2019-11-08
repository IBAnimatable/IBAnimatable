// swiftlint:disable:next operator_usage_whitespace
#!/usr/bin/swift

import Foundation
import UIKit

func colorLiteral(hexString: String) -> String {
  let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
  var int = UInt64()
  Scanner(string: hex).scanHexInt64(&int)
  let a, r, g, b: UInt64
  switch hex.characters.count {
  case 3:
    (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
  case 6:
    (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
  case 8:
    (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
  default:
    (a, r, g, b) = (1, 1, 1, 0)
  }

  return "#colorLiteral(red: \(CGFloat(r) / 255), green: \(CGFloat(g) / 255), blue: \(CGFloat(b) / 255), alpha: \(CGFloat(a) / 255))"
}

extension String {
  func lowercaseFirstLetter() -> String {
    let first = String(characters.prefix(1)).lowercased()
    let other = String(characters.dropFirst())
    return first + other
  }
}

// MARK: - Script

let gradientTypeURL = "https://raw.githubusercontent.com/Ghosh/uiGradients/master/gradients.json"

func JSON(_ urlToRequest: String) -> Data {
  guard let data = try? Data(contentsOf: URL(string: urlToRequest)!) else {
    fatalError("URL Request failed")
  }
  return data
}

func parse(_ JSONData: Data) -> [[String: AnyObject]]? {
  var json: [[String: AnyObject]]?
  do {
    json = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as? [[String: AnyObject]]
    return json
  } catch {
    print("JSON serialization did fail")
    return nil
  }
}

// Generator constants
let enumCase = "\tcase %@\n"
let switchCase = "case .%@:\n"
let colors =  "\treturn (%@, %@)\n"
let endEnumOrSwitch = "}"

// Finale string
var enumGradientType = "public enum GradientType: String {\n"
var switchPredefinedGradientType = "switch gradientType {\n"

// Enum generator
let gradientsType = parse(JSON(gradientTypeURL))
for gradient in gradientsType! {
  // swiftlint:disable:next for_where
  if var name = gradient["name"] as? String,
    let colors = gradient["colors"] as? [String],
    let startColor = colors.first,
    let endColor = colors.last {
    name = name.capitalized
    name = name.replacingOccurrences(of: " ", with: "").lowercaseFirstLetter()
    enumGradientType += String(format: enumCase, name)
    switchPredefinedGradientType += String(format: switchCase, name)
    switchPredefinedGradientType += String(format: colors, colorLiteral(hexString: startColor), colorLiteral(hexString: endColor))
  }
}

enumGradientType += endEnumOrSwitch
switchPredefinedGradientType += endEnumOrSwitch
print(enumGradientType)
print("\n")
print(switchPredefinedGradientType)
