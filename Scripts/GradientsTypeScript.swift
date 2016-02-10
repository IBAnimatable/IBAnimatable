#!/usr/bin/swift

import Foundation

let gradientTypeURL = "https://raw.githubusercontent.com/Ghosh/uiGradients/master/gradients.json"

func JSONFromURL(urlToRequest: String) -> NSData {
    return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
}

func parseJSON(JSONData: NSData) -> [[String: AnyObject]]? {
    var json: [[String: AnyObject]]?
    do {
        json = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .MutableContainers) as? [[String: AnyObject]]
        return json
    } catch {
        print("JSON serialization did fail")
        return nil
    }
}

// Generator constants
let enumCase = "\tcase %@\n"
let switchCase = "case .%@:\n"
let colors =  "\treturn (UIColor(hexString: \"%@\"), UIColor(hexString: \"%@\"))\n"
let endEnumOrSwitch = "}"

// Finale string
var enumGradientType = "public enum GradientType: String {\n"
var switchPredefinedGradientType = "switch gradientType {\n"

// Enum generator
let gradientsType = parseJSON(JSONFromURL(gradientTypeURL))
for gradient in gradientsType! {
    if  var name = gradient["name"] as? String,
        let unwrappedColors = gradient["colors"] as? [String],
        let startColor = unwrappedColors.first,
        let endColor = unwrappedColors.last {
            name = name.stringByReplacingOccurrencesOfString(" ", withString: "")
            enumGradientType += String(format: enumCase, name)
            switchPredefinedGradientType += String(format: switchCase, name)
            switchPredefinedGradientType += String(format: colors, startColor, endColor)
    }
}

enumGradientType += endEnumOrSwitch
switchPredefinedGradientType += endEnumOrSwitch
print(enumGradientType)
print("\n")
print(switchPredefinedGradientType)
