//
//  FlowCoordinator.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit
import class Core.NavigationController

public protocol FlowCoordinator: AnyObject {
    
    // this variable must only be of `weak` type
    var containerViewController: UIViewController? { get set }
    
    @discardableResult
    func createFlow() -> UIViewController
}

public extension FlowCoordinator {
    
    var navigationController: UINavigationController? {
        return containerViewController as? UINavigationController
    }
    
    func push(viewController: UIViewController, animated: Bool = true) {
        Logger.assert(navigationController != nil, "attempt to push without navigationController \(self)")
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        Logger.assert(navigationController != nil, "attempt to pop without navigationController \(self)")
        if let controller = navigationController as? NavigationController {
            controller.popViewController(animated: animated, completion: completion)
        } else {
            Logger.assert(completion == nil, "attempt to pop with completion on incorrect controller \(self)")
            navigationController?.popViewController(animated: animated)
        }
    }
    
    func pop(count: Int, animated: Bool = true, completion: (() -> Void)? = nil) {
        Logger.assert(navigationController != nil, "attempt to pop without navigationController \(self)")
        if let controller = navigationController as? NavigationController {
            controller.popViewController(count: count, animated: animated, completion: completion)
        } else {
            Logger.assert(completion == nil, "attempt to pop with completion on incorrect controller \(self)")
            let viewControllers: [UIViewController] = navigationController?.viewControllers ?? []
            guard viewControllers.count > count else {
                return
            }
            navigationController?.popToViewController(viewControllers[viewControllers.count - count - 1], animated: animated)
        }
    }
    
    func dismiss() {
        Logger.assert(navigationController != nil, "attempt to dismiss without navigationController \(self)")
        navigationController?.dismiss(animated: true, completion: nil)
    }

    func popToRoot() {
        Logger.assert(navigationController != nil, "attempt to pop without navigationController \(self)")
        navigationController?.popToRootViewController(animated: true)
    }
    
    func present(viewController: UIViewController) {
        Logger.assert(containerViewController != nil, "attempt to present without containerViewController \(self)")
        containerViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func removeBeforeLast() {
        Logger.assert(navigationController != nil, "attempt to push without navigationController \(self)")
        if let count = navigationController?.viewControllers.count,
           count >= 2 {
            navigationController?.viewControllers.remove(at: count - 2)
        }
    }
}
