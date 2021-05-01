//
//  AppDelegate.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 16.04.2021.
//

import UIKit

protocol AppService: AnyObject {}

typealias AppDelegateService = AppService & UIApplicationDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? {
        get {
            for service in services {
                if let window = service.window {
                    return window
                }
            }
            
            return nil
        }
        
        set {}
    }
    
    let services: [AppDelegateService]
    
    override init() {
        services = [
            ApplicationFlowService()
        ]
        
        super.init()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return services.allSatisfy {
            $0.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? true
        }
    }
}
