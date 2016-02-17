//
//  StringExtension.swift
//  devi
//
//  Created by Han Ngo on 2/17/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}