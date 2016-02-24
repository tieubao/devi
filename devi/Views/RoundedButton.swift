//
//  RoundedButton.swift
//  devi
//
//  Created by Han Ngo on 2/17/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import UIKit

// A round button used to draw the Info button
class RoundedButton: CustomButton {
    
    var normalFillColor = UIColor.darkTextColor()
    var highlightedFillColor = UIColor(hexString: "#111111", alpha: 1)!
    var disabledFillColor = UIColor.lightGrayColor()
    
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTitleColors()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColors()
    }
    
    private func setTitleColors() {
        setTitleColor(UIColor.whiteColor(), forState: .Normal)
        setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        setTitleColor(UIColor.whiteColor(), forState: .Disabled)
    }
    
    override func customDraw(rect: CGRect) {
        let insetDeltaX: CGFloat = 6.0
        let insetDeltaY: CGFloat = 6.0
        
        var roundRect = CGRectInset(self.bounds, insetDeltaX, insetDeltaY)
        roundRect.origin.x += offsetX
        roundRect.origin.y += offsetY
        let path = UIBezierPath(ovalInRect: roundRect)
        
        if highlighted {
            highlightedFillColor.setFill()
        } else if enabled {
            normalFillColor.setFill()
        } else {
            disabledFillColor.setFill()
        }
        
        path.fill()
    }
}