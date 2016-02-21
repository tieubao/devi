//
//  SquareBorderButton.swift
//  devi
//
//  Created by Han Ngo on 2/17/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import UIKit

// A square button used to draw the up/down button
class SquareBorderButton: CustomButton {
    var borderInsetDeltaX: CGFloat = 1.0
    var borderInsetDeltaY: CGFloat = 1.0
    var lineWidth: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTitleColors()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColors()
    }
    
    private func setTitleColors() {
        setTitleColor(UIColor(hexString: "#2C2C38", alpha: 1)!, forState: .Normal)
        setTitleColor(UIColor(hexString: "#AAAAAA", alpha: 1)!, forState: .Highlighted)
    }
    
    override func customDraw(rect: CGRect) {
        let path = UIBezierPath(rect: CGRectInset(self.bounds, borderInsetDeltaX, borderInsetDeltaY))
        
        if highlighted {
            titleColorForState(.Highlighted)!.setStroke()
        } else if enabled {
            titleColorForState(.Normal)!.setStroke()
        } else {
            titleColorForState(.Disabled)!.setStroke()
        }
        
        path.lineWidth = lineWidth
        path.stroke()
    }
}