//
//  SettingViewController.swift
//  devi
//
//  Created by Han Ngo on 2/18/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class SettingViewController: UITableViewController, TipRateSliderDelegate {
    
    @IBOutlet var settingTableView: UITableView!
    var sectionCount: Int = 2
    
    let tipRateCellId = "TipRateSliderCell"
    let normalCellId = "Cell"
    let versionCellId = "VersionCell"
    let detailCellId = "DetailCell"
    
    let aboutSectionTitles = [
        "Version",
        //        "Acknowledgments",
        //        "Disclaimer",
    ]
    
    override func viewDidLoad() {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Setting", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        // Init table view
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: normalCellId)
    }
    
    // Set custom height for each section
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 38.0
        }
        
        return super.tableView(self.tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // Disable highlight of first row
        if indexPath.section == 0 && indexPath.row == 0 {
            return false
        }
        
        return true
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Info"
        case 1:
            return "Config"
        default:
            return super.tableView(self.tableView, titleForHeaderInSection: section)
        }
    }
    
    // return size of table view sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    // return number of rows in each section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return aboutSectionTitles.count
        }
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0: // Info section
            
            var cell: UITableViewCell?
            
            switch indexPath.row {
            case 0: // Version
                cell = tableView.dequeueReusableCellWithIdentifier(versionCellId)
                if cell == nil {
                    cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: versionCellId)
                }
                cell!.detailTextLabel!.text = "1.0"
                
            default:
                cell = tableView.dequeueReusableCellWithIdentifier(detailCellId)
                if cell == nil {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: detailCellId)
                    cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                }
            }
            
            let textLabel: UILabel? = cell!.textLabel
            textLabel!.text = aboutSectionTitles[indexPath.row]
            return cell!
            
        case 1: // Default tip rate section
            
            var cell = tableView.dequeueReusableCellWithIdentifier(tipRateCellId, forIndexPath: indexPath) as? TipRateSliderCell
            
            // Load cell from Nib file
            if cell == nil {
                var nib: Array = NSBundle.mainBundle().loadNibNamed("TipRateSliderCell", owner: self, options: nil)
                cell = nib[0] as? TipRateSliderCell
            }
            
            cell?.delegate = self
            
            // Set value for slider
            cell?.slider.value = Float(Defaults[DefaultsKeys.defaultRateKey])
            cell?.defaultTipLabel.text = "\(Int(Defaults[DefaultsKeys.defaultRateKey]))"
            return cell!
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        log.debug("You selected cell #\(indexPath.row)!")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func dismissAction(sender: AnyObject) {
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     Store value of slider into NSUserDefault
     
     - parameter value: value of slider after changed
     */
    func sliderValueChanged(value: Int) {
        Defaults[DefaultsKeys.defaultRateKey] = Double(value)
        log.info("Persist default tip rate")
    }
}