//
//  AppDelegate.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import UIKit
import WeatherCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let ctrl = SearchLocationTableViewController()
        let nav = UINavigationController(rootViewController: ctrl)
        nav.navigationBar.prefersLargeTitles = true

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        #if targetEnvironment(macCatalyst)
            window.windowScene?.titlebar?.titleVisibility = .hidden
            window.windowScene?.sizeRestrictions?.minimumSize.width = 450 * 3
            window.windowScene?.sizeRestrictions?.minimumSize.height = 600
        #endif
        
        // remove previous from memory
        self.window?.rootViewController = nil
        self.window = window
        return true
    }

}

