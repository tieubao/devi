//
//  RoundedButton.swift
//  devi
//
//  Created by Han Ngo on 2/17/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    var extendedHitAreaEdgeInset = UIEdgeInsetsZero

    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        let hitBounds = UIEdgeInsetsInsetRect(bounds, extendedHitAreaEdgeInset)
        return CGRectContainsPoint(hitBounds, point)
    }

    override func drawRect(rect: CGRect) {
        customDraw(rect)
        super.drawRect(rect)
    }

    func customDraw(rect: CGRect) {
    }

    override var selected: Bool {
        get {
            return super.selected
        }
        set {
            super.selected = newValue
            setNeedsDisplay()
        }
    }

    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            super.highlighted = newValue
            setNeedsDisplay()
        }
    }
}