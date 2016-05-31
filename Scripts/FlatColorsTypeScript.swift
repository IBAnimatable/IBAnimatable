#!/usr/bin/swift

import Foundation

let colorsTypeURL = "https://gist.githubusercontent.com/tkrugg/a577c32e93eecc6c7991/raw/f7866132e26f9bffcda9caf13dced55e4a99e145/flatuicolors.json"

func JSONFromURL(urlToRequest: String) -> NSData {
  return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
}

func parseJSON(JSONData: NSData) -> [String: String]? {
  var json: [String: String]?
  do {
    json = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .MutableContainers) as? [String: String]
    return json
  } catch {
    print("JSON serialization did fail")
    return nil
  }
}

// Generator constants
let enumCase = "\tcase %@\n"
let switchCase = "case .%@:\n"
let color =  "\treturn UIColor(red: %@ / 255, green: %@ / 255, blue: %@ / 255, alpha: %@)\n"
let endEnumOrSwitch = "}"

// Finale string
var enumColorType = "public enum ColorType: String {\n"
var switchColorType = "switch colorType {\n"

// Enum generator
let colorsType: Dictionary? = parseJSON(JSONFromURL(colorsTypeURL))

// Parsing
if let uwnrappedColorsType = colorsType {
  for colorName in uwnrappedColorsType.keys {
    if var unwrappedRGBColors = uwnrappedColorsType[colorName] {
      var finalName = colorName.capitalizedStringWithLocale(NSLocale.currentLocale())
      finalName = finalName.stringByReplacingOccurrencesOfString("-", withString: "")
      finalName = "Flat" + finalName
      enumColorType += String(format: enumCase, finalName)
      switchColorType += String(format: switchCase, finalName)
      
      unwrappedRGBColors = unwrappedRGBColors.stringByReplacingOccurrencesOfString("rgba(", withString: "")
      unwrappedRGBColors = unwrappedRGBColors.stringByReplacingOccurrencesOfString(")", withString: "")
      let colors = unwrappedRGBColors.componentsSeparatedByString(",")
      switchColorType += String(format: color, colors[0], colors[1], colors[2], colors[3])
    }
  }
  
  enumColorType += endEnumOrSwitch
  switchColorType += endEnumOrSwitch
  print(enumColorType)
  print("\n")
  print(switchColorType)
}
