//
//  Constant.swift
//  devi
//
//  Created by Han Ngo on 2/17/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import UIKit

class Constant: NSObject {

    static var keypadTextColor = UIColor.whiteColor()
    static var keypadBackgroundColor: UIColor {
        return UIColor(hexString: "#2C2C38", alpha: 1)!
    }

    static var keypadTextHighlightColor: UIColor {
        return UIColor(hexString: "#262630", alpha: 1)!
    }

    static var dividingLineColor: UIColor {
        return UIColor(hexString: "#EEEEEE", alpha: 1)!
    }
}