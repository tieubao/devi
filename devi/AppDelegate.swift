//
//  AppDelegate.swift
//  devi
//
//  Created by Han Ngo on 2/16/16.
//  Copyright © 2016 Han Ngo. All rights reserved.
//

import UIKit
import XCGLogger
import SwiftyUserDefaults

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let log: XCGLogger = {
    
    // Setup XCGLogger
    let log = XCGLogger.defaultInstance()
    log.xcodeColorsEnabled = true // Or set the XcodeColors environment variable in your scheme to YES
    log.xcodeColors = [
        .Verbose: .lightGrey,
        .Debug: .darkGrey,
        .Info: .darkGreen,
        .Warning: .orange,
        .Error: XCGLogger.XcodeColor(fg: UIColor.redColor(), bg: UIColor.whiteColor()), // Optionally use a UIColor
        .Severe: XCGLogger.XcodeColor(fg: (255, 255, 255), bg: (255, 0, 0)) // Optionally use RGB values directly
    ]
    
    
    log.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil)
    return log
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        if Defaults[DefaultsKeys.defaultRateKey] < 10 {
            Defaults[DefaultsKeys.defaultRateKey] = 10
            log.debug("Init default tip rate = 10%")
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
        // save current timestamp
        let now = NSDate().timeIntervalSince1970
        Defaults[DefaultsKeys.lastActiveTime] = Int(now)
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        let lastTime = Defaults[DefaultsKeys.lastActiveTime]
        let now = Int(NSDate().timeIntervalSince1970)
        
        if now - lastTime > 600 {
            log.info("Back to app after 10 minutes. Need to reset tip cal values")
            
            // Clear NSUserDefault data
            Defaults[DefaultsKeys.billAmountKey] = ""
            Defaults[DefaultsKeys.peopleKey] = 1
            Defaults[DefaultsKeys.rateKey] = 0.0
            Defaults[DefaultsKeys.dotButtonPressed] = false
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

