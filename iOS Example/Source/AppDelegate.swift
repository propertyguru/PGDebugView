//
//  AppDelegate.swift
//  iOS Example
//
//  Created by Suraj Pathak on Sep 23, 2016.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import UIKit
import PGDebugView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()

        /*
        if let path = Bundle.main.path(forResource: "Debug", ofType: "plist") {
            let debugVC = PGDebugViewController(plistPath: path, readOnly: false)
            window?.rootViewController = UINavigationController(rootViewController: debugVC)
            window?.makeKeyAndVisible()z
        }
 */
        return true
    }
}
