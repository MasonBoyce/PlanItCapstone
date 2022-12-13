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
    
    //Once the application laucnhes this is the first thing
    //Create the initial screen window,navcontroller and sets root view controller
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationCon = UINavigationController()
        
        appCoordinator = AppCoordinator(navCon: navigationCon)
        appCoordinator?.start()
        
        self.window?.rootViewController = navigationCon
        self.window?.makeKeyAndVisible()
    
        
        return true
    }
    
    
}

