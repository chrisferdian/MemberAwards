//
//  AppDelegate.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 08/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.setRootViewController(WelcomeViewController())
        
        return true
    }
}
