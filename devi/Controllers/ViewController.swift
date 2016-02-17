//
//  ViewController.swift
//  devi
//
//  Created by Han Ngo on 2/16/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

var statusBarIsHidden = true
class ViewController: UIViewController, NumericKeypadDelegate {

    @IBOutlet var numericKeypadView: NumericKeypadView!
    @IBOutlet var billAmountLabel: UILabel!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var totalAmountLabel: UILabel!
    @IBOutlet var numberOfPeopleLabel: UILabel!
    @IBOutlet var eachAmountLabel: UILabel!
    @IBOutlet var infoButton: RoundedButton!

    @IBOutlet var tipRateLabel: UILabel!
    @IBOutlet var tipUpButton: SquareBorderButton!
    @IBOutlet var tipDownButton: SquareBorderButton!

    @IBOutlet var peopleUpButton: SquareBorderButton!
    @IBOutlet var peopleDownButton: SquareBorderButton!

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

        // Load data from NSUserDefault
        keypadString = Defaults[DefaultsKeys.billAmountKey]

        // Set tip rate default value to 0.1
        tipRate = Float(Defaults[DefaultsKeys.rateKey])
        if tipRate < 0.1 {
            tipRate = 0.1
        }

        // Make sure min People always >= 1
        numberOfPeople = Defaults[DefaultsKeys.peopleKey]
        if numberOfPeople < 1 {
            numberOfPeople = 1
        }

        // Reload UI
        updateViews()
    }

    // MARK: implement NumericKeypadDelegate
    func numberTapped(number: Int) {

        if number == 0 && keypadString.isEmpty { return }
        if keypadString.characters.count > 5 { return }
        if dotButtonPressed && fractionDigits == 2 { return }

        if dotButtonPressed {
            fractionDigits = fractionDigits + 1
        }

        if dotButtonPressed && fractionDigits == 0 {
            keypadString = keypadString + "."
        }

        keypadString = keypadString + String(number)
        updateViews()
    }

    /**
     Handle Clear button tapped event
     */
    func clearTapped() {

        // Clean up all states and update UI
        keypadString = ""
        billAmountLabel.text = "0.0"
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
            dotButtonPressed = true
            updateViews()
        }
    }

    func updateViews() {

        // Update bill amount
        billAmount = keypadString.floatValue
        billAmountLabel.text = "\(billAmount)"

        // Update tip amount
        tipRateLabel.text = "\(Int(tipRate * 100))% Tip"
        tipAmount = Float(round(100 *  billAmount * tipRate)/100)
        tipAmountLabel.text = "\(tipAmount)"

        // Update total amount
        totalAmount = tipAmount + billAmount
        totalAmountLabel.text = "\(totalAmount)"

        // Update each amount
        numberOfPeopleLabel.text = "\(numberOfPeople) P"
        eachAmount = Float(round(100 *  totalAmount / Float(numberOfPeople))/100)
        eachAmountLabel.text = "\(eachAmount)"

        // Store bill value to NSUserDefault
        Defaults[DefaultsKeys.billAmountKey] = keypadString
        Defaults[DefaultsKeys.peopleKey] = numberOfPeople
        Defaults[DefaultsKeys.rateKey] = Double(tipRate)
    }

    // increase tip rate 5%. MAX = 50%
    @IBAction func tipUp(sender: AnyObject) {
        if tipRate >= 0.5 { return }
        tipRate = tipRate + 0.05
        updateViews()
    }

    // decrease tip rate 5%. MIN = 5%
    @IBAction func tipDown(sender: AnyObject) {
        if tipRate < 0.1 { return }
        tipRate = tipRate - 0.05
        updateViews()
    }

    @IBAction func peopleUp(sender: AnyObject) {
        if numberOfPeople >= 1000 { return }
        numberOfPeople = numberOfPeople + 1
        updateViews()
    }

    @IBAction func peopleDown(sender: AnyObject) {
        if numberOfPeople <= 1 { return }
        numberOfPeople = numberOfPeople - 1
        updateViews()
    }

    override func prefersStatusBarHidden () -> Bool {return statusBarIsHidden}
}

