//
//  AppDelegate.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let router = Router()
        let navVC = UINavigationController(rootViewController: router.mainVC())
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        return true
    }

}

