//
//  AppDelegate.swift
//  AppEventCount
//
//  Created by Justin Snider on 10/24/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewController: ViewController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        viewController = window?.rootViewController as? ViewController
        viewController?.launchCount += 1
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        viewController = window?.rootViewController as? ViewController
        viewController?.willResignActiveCount += 1
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        viewController = window?.rootViewController as? ViewController
        viewController?.didEnterBackgroundCount += 1
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        viewController = window?.rootViewController as? ViewController
        viewController?.willEnterForeGroundCount += 1
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        viewController = window?.rootViewController as? ViewController
        viewController?.didBecomeActiveCount += 1
        viewController?.updateView()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        viewController = window?.rootViewController as? ViewController
        viewController?.willTerminateCount += 1
    }


}

