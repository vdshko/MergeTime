//
//  ApplicationFlowService.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 18.04.2021.
//

import UIKit

final class ApplicationFlowService: NSObject, AppDelegateService {
    
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
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
