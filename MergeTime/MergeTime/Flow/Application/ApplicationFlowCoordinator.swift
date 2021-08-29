//
//  ApplicationFlowCoordinator.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 18.04.2021.
//

import Swinject

typealias NavigationFlowCoordinator = NavigationNode & FlowCoordinator

final class ApplicationFlowCoordinator: NavigationFlowCoordinator {
    
    weak var containerViewController: UIViewController?
    
    private weak var window: UIWindow?
    
    private let container: Container
    
    init(window: UIWindow?) {
        self.window = window
        container = Container { (container: Container) in
            ApplicationFlowAssembly().assemble(container: container)
        }
        
        super.init(parent: nil)
    }
    
    @discardableResult
    func createFlow() -> UIViewController {
        return presentMainFlow()
    }
    
    func presentMainFlow() -> UIViewController {
        let coordinator: MainFlowCoordinator = container.autoresolve(argument: self)
        let controller = coordinator.createFlow()
        setRootViewController(as: controller)
        
        return controller
    }
    
    private func setRootViewController(as viewController: UIViewController) {
        if let modalViewController = window?.rootViewController,
           modalViewController.presentedViewController != nil {
            modalViewController.dismiss(animated: true) { [weak window] in
                window?.rootViewController = viewController
                window?.makeKeyAndVisible()
            }
            
            return
        }
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
