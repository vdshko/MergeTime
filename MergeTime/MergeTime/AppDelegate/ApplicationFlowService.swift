//
//  ApplicationFlowService.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 18.04.2021.
//

import UIKit

final class ApplicationFlowService: NSObject, AppDelegateService {
    
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    private var applicationFlowCoordinator: ApplicationFlowCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        applicationFlowCoordinator = ApplicationFlowCoordinator(window: window)
        applicationFlowCoordinator?.createFlow()
        
        return true
    }
}
