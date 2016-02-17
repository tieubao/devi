//
//  UIColorExtension.swift
//  devi
//
//  Created by Han Ngo on 2/17/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hexString: String, alpha: CGFloat) {
        let r, g, b, a: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.startIndex.advancedBy(1)
            let hexColor = hexString.substringFromIndex(start)

            if hexColor.characters.count == 6 {
                let scanner = NSScanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexLongLong(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    a = alpha//CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }

    /**
     Construct a UIColor using an HTML/CSS RGB formatted value and an alpha value

     - parameter rgbValue: rgbValue RGB value
     - parameter alpha: alpha color alpha value

     - returns: an UIColor instance that represent the required color
     */
    class func colorWithRGB(rgbValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     Returns a lighter color by the provided percentage

     - parameter percent: lighting percent percentage

     - returns: lighter UIColor
     */
    func lighterColor(percent: Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 + percent))
    }

    /**
     Returns a darker color by the provided percentage

     - parameter percent: darking percent percentage
     - returns: darker UIColor
     */
    func darkerColor(percent: Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 - percent))
    }

    /**
     Return a modified color using the brightness factor provided

     - parameter factor: factor brightness factor
     - returns: modified color
     */
    func colorWithBrightnessFactor(factor: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
        } else {
            return self
        }
    }
}