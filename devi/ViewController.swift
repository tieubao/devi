//
//  ViewController.swift
//  devi
//
//  Created by Han Ngo on 2/16/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import UIKit

var statusBarIsHidden = true
class ViewController: UIViewController, NumericKeypadDelegate {


    @IBOutlet var numericKeypadView: NumericKeypadView!
    @IBOutlet var billAmountLabel: UILabel!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var totalAmountLabel: UILabel!
    @IBOutlet var numberOfPeopleLabel: UILabel!
    @IBOutlet var eachAmountLabel: UILabel!

    //
    var keypadString = ""

    var tipAmount: Float = 0.0
    var tipRate: Float = 0.15
    var billAmount: Float = 0.0
    var totalAmount: Float = 0.0
    var eachAmount: Float = 0.0
    var numberOfPeople: Int = 1
    var fractionDigits: Int = 0

    var dotButtonPressed: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup colors for keypad
        numericKeypadView.keypadTextColor = Constant.keypadTextColor
        numericKeypadView.keypadBackgroundColor = Constant.keypadBackgroundColor
        numericKeypadView.delegate = self
    }

    // MARK: implement NumericKeypadDelegate
    func numberTapped(number: Int) {

        if dotButtonPressed && fractionDigits == 2 { return }
        if number == 0 && keypadString.isEmpty { return }
        if keypadString.characters.count > 5 { return }

        keypadString = keypadString + String(number)
        fractionDigits = fractionDigits + 1
        updateViews()
    }

    /**
     Handle Clear button tapped event
     */
    func clearTapped() {

        // Clean up all states and update UI
        keypadString = ""
        billAmountLabel.text = "0.00"
        dotButtonPressed = false
        fractionDigits = 0
        numberOfPeople = 1
        updateViews()
    }

    /**
     Handle dot button tapped event
     */
    func dotTapped() {

        if keypadString.characters.count > 5 { return }
        if dotButtonPressed == false {
            keypadString = keypadString + "."
            dotButtonPressed = true
            updateViews()
        }
    }

    func updateViews() {

        // Update bill amount
        billAmount = keypadString.floatValue
        billAmountLabel.text = "\(billAmount)"

        // Update tip amount
        tipAmount = Float(round(100 *  billAmount * tipRate)/100)
        tipAmountLabel.text = "\(tipAmount)"


        // Update total amount
        totalAmount = tipAmount + billAmount
        totalAmountLabel.text = "\(totalAmount)"

        // Update each amount
        eachAmount = totalAmount / Float(numberOfPeople)
        eachAmountLabel.text = "\(eachAmount)"
    }

    override func prefersStatusBarHidden () -> Bool {return statusBarIsHidden}
}

