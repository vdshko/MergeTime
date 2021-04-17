//
//  AppDelegate.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 16.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupTestFirstScreen()
        
        return true
    }
    
    // TBD: remove after finish setup
    
    private func setupTestFirstScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
