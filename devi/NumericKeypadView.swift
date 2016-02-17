//
//  NumericKeypadView.swift
//  devi
//
//  Created by Han Ngo on 2/17/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import UIKit

protocol NumericKeypadDelegate {
    func numberTapped(number: Int)
    func clearTapped()
    func dotTapped()
}

/// Custom Numeric Keypad View
/// Draw new UI
/// Override events: touch, move, end, cancel
class NumericKeypadView: UIView {

    var delegate: NumericKeypadDelegate?
    var selectedKey = -1
    var gridView = GridView()
    var labels = [OffsetLabel]()

    // MARK: Default colors of keypad
    var keypadBackgroundColor: UIColor = UIColor(hexString: "#2C2C38", alpha: 1)! {
        didSet {
            for label in labels {
                label.layer.backgroundColor = keypadBackgroundColor.CGColor
            }
        }
    }

    var keypadHighlightColor = UIColor(hexString: "#262630", alpha: 1)!

    var keypadTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            for label in labels {
                label.textColor = keypadTextColor
            }
        }
    }

    var keypadTextHighlightColor = UIColor.whiteColor()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        for var i = 0; i < 12; i++ {
            var label: OffsetLabel
            label = OffsetLabel(frame: CGRectZero)

            var keyStr: String
            switch i {
            case 9:
                keyStr = "\u{200b}.\u{200b}"
            case 10:
                keyStr = "\u{200b}0\u{200b}"
            case 11:
                keyStr = "\u{200b}C\u{200b}"
            default:
                keyStr = String(format: "\u{200b}%d\u{200b}", i + 1)
            }

            label.text = keyStr
            label.numberOfLines = 1
            label.textColor = keypadTextColor
            label.accessibilityTraits |= UIAccessibilityTraitButton

            labels.append(label)
            label.layer.backgroundColor = keypadBackgroundColor.CGColor
            label.textAlignment = .Center
            label.opaque = true

            addSubview(label)
        }

        gridView.backgroundColor = UIColor.clearColor()
        gridView.opaque = true
        addSubview(gridView)    // call layoutSubviews()
    }

    /**
     Override this function to set frame for each keypad
     */
    override func layoutSubviews() {

        // Set frame for each keypad
        for var i = 0; i < 12; i++ {
            let frame = keyRect(i)
            labels[i].frame = frame
        }

        // Set frame for grid view
        gridView.frame = bounds
    }

    /**
     Calcalate position of target keypad

     - parameter index: index of keypad

     - returns: position of keypad
     */
    private func keyRect(index: Int) -> CGRect {
        let keyW = round(self.bounds.width / 3.0)
        let keyH = round(self.bounds.height / 4.0)
        let origin = CGPoint(x: (CGFloat(index % 3) * keyW), y: (CGFloat(index / 3) * keyH))
        let size = CGSize(width: keyW, height: keyH)
        return CGRect(origin: origin, size: size)
    }

    /**
     Calculate the keypad based on the touch location

     - parameter point: touch location

     - returns: Index of the touched keypad
     */
    private func pointToKeyIndex(point: CGPoint) -> Int {
        if (!CGRectContainsPoint(self.bounds, point)) {
            return -1
        }
        let keyW = self.bounds.width / 3.0
        let keyH = self.bounds.height / 4.0
        let xIndex = Int(point.x / keyW)
        let yIndex = Int(point.y / keyH)
        return yIndex * 3 + xIndex
    }

    /**
     Get selected label based on given index

     - parameter index: selected index

     - returns: Selected label
     */
    private func getSelectedLabel(index: Int) -> UILabel? {
        if index >= 0 && index < labels.count {
            return labels[index]
        }
        return nil
    }

    /**
     Override touchesBegan to add Highlight animations

     - parameter touches: touches
     - parameter event:   event
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self)
        let endSelectedKey = pointToKeyIndex(location)

        // Highlight animations
        if endSelectedKey != selectedKey {

            // Set normal color for old label
            if let oldLabel = getSelectedLabel(selectedKey) {
                oldLabel.layer.backgroundColor = keypadBackgroundColor.CGColor
                oldLabel.textColor = keypadTextColor
            }

            selectedKey = endSelectedKey

            // Set highlight color for pressed keypad
            if let newLabel = getSelectedLabel(selectedKey) {
                newLabel.layer.backgroundColor = keypadHighlightColor.CGColor
                newLabel.textColor = keypadTextHighlightColor
            }
        }
    }

    /**
     Override touchesMove to add Highlight animations

     - parameter touches: touches
     - parameter event:   event
     */
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self)
        let endSelectedKey = pointToKeyIndex(location)

        if endSelectedKey != selectedKey {

            // Set normal color for old label
            if let oldLabel = getSelectedLabel(selectedKey) {
                oldLabel.layer.backgroundColor = keypadBackgroundColor.CGColor
                oldLabel.textColor = keypadTextColor
            }

            selectedKey = endSelectedKey

            // Set highlight color for pressed keypad
            if let newLabel = getSelectedLabel(selectedKey) {
                newLabel.layer.backgroundColor = keypadHighlightColor.CGColor
                newLabel.textColor = keypadTextHighlightColor
            }
        }
    }

    /**
     Override touchesEnded to reset states for the keypad if user ended touch event

     - parameter touches: <#touches description#>
     - parameter event:   <#event description#>
     */
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self)
        let endSelectedKey = pointToKeyIndex(location)

        if selectedKey == -1 { return }
        if endSelectedKey == selectedKey {
            switch selectedKey {
            case 9:
                delegate?.dotTapped()
            case 10:
                delegate?.numberTapped(0)
            case 11:
                delegate?.clearTapped()
            default:
                delegate?.numberTapped(selectedKey + 1)
            }

            if let oldLabel = getSelectedLabel(selectedKey) {
                UIView.animateWithDuration(0.2, animations: {
                    oldLabel.layer.backgroundColor = self.keypadBackgroundColor.CGColor
                    oldLabel.textColor = self.keypadTextColor
                })
            }

            selectedKey = -1
            return
        }

        // Reset state for selectedKey
        selectedKey = -1
    }

    /**
     Override func touchesCancelled to reset states for pressed label and selected key if user cancelled touch event

     - parameter touches: touches
     - parameter event:   event
     */
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if let oldLabel = getSelectedLabel(selectedKey) {
            oldLabel.layer.backgroundColor = keypadBackgroundColor.CGColor
            oldLabel.textColor = keypadTextColor
        }

        selectedKey = -1
    }

    /// Custom label control with insets
    class OffsetLabel: UILabel {
        var inset: UIEdgeInsets = UIEdgeInsetsZero
        override func drawTextInRect(rect: CGRect) {
            super.drawTextInRect(UIEdgeInsetsInsetRect(rect, inset))
        }
    }

    /// Custom grid view
    class GridView: UIView {
        var gridColor = UIColor.darkGrayColor()

        // override function draw
        override func drawRect(rect: CGRect) {

            // calcucate size of 1 key
            let path = UIBezierPath()
            let keyW = round(self.bounds.width / 3.0)
            let keyH = round(self.bounds.height / 4.0)

            //
            for var x = 1; x < 3; x++ {
                path.moveToPoint(CGPoint(x: CGFloat(x) * keyW, y: 0))
                path.addLineToPoint(CGPoint(x: CGFloat(x) * keyW, y: self.bounds.height))
            }

            //
            for var y = 1; y < 4; y++ {
                path.moveToPoint(CGPoint(x: 0, y: CGFloat(y) * keyH))
                path.addLineToPoint(CGPoint(x: self.bounds.width, y: CGFloat(y) * keyH))
            }

            gridColor.setStroke()
            path.stroke()
        }
    }

}