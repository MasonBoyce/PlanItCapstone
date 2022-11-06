//
//  AppDelegate.swift
//  PlanIt
//
//  Created by Mason Boyce on 10/17/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator : AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//         Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationCon = UINavigationController()
        appCoordinator = AppCoordinator(navCon: navigationCon)
        appCoordinator?.start()
        self.window?.rootViewController = navigationCon
        self.window?.makeKeyAndVisible()
                 
        return true
    }

}

