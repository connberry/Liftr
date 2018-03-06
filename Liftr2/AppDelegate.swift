//  AppDelegate.swift
//  Liftr2
//  Created by Connor Berry on 07/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import CoreData
import Firebase
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Firebase configuration for the rest of the app.
    var window: UIWindow?
    override init()
    { FirebaseApp.configure() }

    // Override point for customization after application launch.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
    // Tab Bar icons when selected and not selected.
    UITabBar.appearance().tintColor = UIColor.white
    UITabBar.appearance().unselectedItemTintColor = UIColor.black
        
    return true
    }
}

