//
//  AppDelegate.swift
//  Alpha
//
//  Created by Cristian Monterroza on 12/7/14.
//  Copyright (c) 2014 wrkstrm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let aKey = "aviaryAPIKey"
    let aSecret = "aviarySecret"
    
    var window: UIWindow?
    var secrets:NSDictionary? {
        get {
            let filePath = NSBundle.mainBundle().pathForResource("secrets", ofType: "json")
            return NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: filePath!)!,
                options:NSJSONReadingOptions.MutableLeaves, error: nil) as NSDictionary?
        }
    }
    
    override class func load() {
        var logger = WSMLogger.sharedInstance()
        logger.formatStyle = WSMLogFormatStyle.Queue
        logger[kWSMLogFormatKeyFile] = NSNumber(integer: 7)
        logger[kWSMLogFormatKeyFunction] = NSNumber(integer: 40)
        DDLog.addLogger(logger)
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [NSObject: AnyObject]?) -> Bool {
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent,
                animated:false)
            window?.tintColor = AppDelegate.sobrrGold()
            AFPhotoEditorController.setAPIKey(secrets![aKey] as String,
                secret: secrets![aSecret] as String)
            AFOpenGLManager.beginOpenGLLoad()
            AFPhotoEditorController.setPremiumAddOns(AFPhotoEditorPremiumAddOn.HiRes)
            return true
    }
    
    class func sobrrGold() -> UIColor {
        return SKColorMakeRGB(250, 213, 142)
    }
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
