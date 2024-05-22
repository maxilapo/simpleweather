//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-15.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: CityListViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}
