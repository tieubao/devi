//
//  DefaultsKeysExtension.swift
//  devi
//
//  Created by Han Ngo on 2/18/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let billAmountKey = DefaultsKey<String>("billAmount")
    static let peopleKey = DefaultsKey<Int>("people")
    static let rateKey = DefaultsKey<Double>("rate")
    static let dotButtonPressed = DefaultsKey<Bool>("dotButtonPressed")
}