//
//  SettingViewController.swift
//  devi
//
//  Created by Han Ngo on 2/18/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UITableViewController {

    @IBOutlet var settingTableView: UITableView!
    var sectionCount: Int = 2

    let tipRateSliderCell = "TipRateSliderCell"
    let infoCell = "InfoCell"

    override func viewDidLoad() {
        // Init
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.registerClass(TipRateSliderCell.self, forHeaderFooterViewReuseIdentifier: tipRateSliderCell)
        settingTableView.registerClass(InfoCell.self, forHeaderFooterViewReuseIdentifier: infoCell)
    }

    // return size of table view sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionCount
    }

    // return number of rows in each section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        for var index = 0; index < sectionCount; index++ {
            switch index {
            default:
                return 1
            }
        }

        return 0
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//    }

    @IBAction func dismissAction(sender: AnyObject) {
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
}

class TipRateSliderCell: UITableViewCell {
    
}

class InfoCell: UITableViewCell {

}