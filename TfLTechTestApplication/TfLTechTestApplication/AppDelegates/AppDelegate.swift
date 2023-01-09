//
//  AppDelegate.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NetworkMonitor.shared.startMonitoring()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        NetworkMonitor.shared.stopMonitoring()
    }

}

