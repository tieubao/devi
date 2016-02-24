//
//  TipRateSliderCell.swift
//  devi
//
//  Created by Han Ngo on 2/25/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import UIKit

protocol TipRateSliderDelegate {
    func sliderValueChanged(value: Int)
}

class TipRateSliderCell: UITableViewCell {
    
    @IBOutlet var defaultTipLabel: UILabel!
    @IBOutlet var slider: UISlider!
    let step: Float = 5
    var delegate: TipRateSliderDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        defaultTipLabel.text = "\(Int(roundedValue))"
        delegate?.sliderValueChanged(Int(roundedValue))
    }
    
}