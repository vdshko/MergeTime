//
//  NavigationController.swift
//  UI
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public class NavigationController: UINavigationController, ViewControllerAppearanceManageable {
    
    public var poppedViewController: (UIViewController) -> Void = { _ in }
    
    // MARK: - Setup
    
    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    private func setup() {
        delegate = self
        if isRootViewControllerSetup {
            return
        }
        
        manageAppearance(with: viewControllers.first)
    }
    
    // MARK: - Appearance management
    
    private var isRootViewControllerSetup = false
    
    public var navigationBarAppearance: NavigationBarAppearance { return .transparent }
    public var navigationBarTint: NavigationBarTint { return .black }
    public var tabBarIsHidden: Bool { return false }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    public override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? false
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        manageAppearance(with: viewController)
    }
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        
        manageAppearance(with: viewControllerToPresent)
    }

    @discardableResult
    open func popViewController(animated: Bool, completion: (() -> Void)?) -> UIViewController? {
        manageAppearance(with: topViewController)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.manageAppearance(with: self?.topViewController)
            completion?()
        }
        let controller = super.popViewController(animated: animated)
        CATransaction.commit()
        
        return controller
    }
    
    @discardableResult
    open func popViewController(count: Int, animated: Bool, completion: (() -> Void)?) -> [UIViewController]? {
        manageAppearance(with: topViewController)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.manageAppearance(with: self?.topViewController)
            completion?()
        }
        let viewControllers: [UIViewController] = super.viewControllers
        guard viewControllers.count > count else {
            return nil
        }
        let controllers = super.popToViewController(viewControllers[viewControllers.count - count - 1], animated: animated)
        CATransaction.commit()
        
        return controllers
    }

    @discardableResult
    override open func popViewController(animated: Bool) -> UIViewController? {
        let poppedController = popViewController(animated: animated, completion: nil)
        if let controller = poppedController {
            poppedViewController(controller)
        }
        
        return poppedController
    }
    
    open override var viewControllers: [UIViewController] {
        didSet {
            if viewControllers.count == 1 {
                manageAppearance(with: viewControllers.first)
            }
        }
    }
    
    private func manageAppearance(with controller: UIViewController?) {
        // at some point system disables animation while transitioning between controllers
        // in order to fix that we manually enable it
        UIView.setAnimationsEnabled(true)
        
        if let appearanceController = controller as? ViewControllerAppearanceManageable {
            appearanceController.updateAppearance(navigationBar)
        } else {
            updateAppearance(navigationBar)
        }
        guard let controller = controller else {
            return
        }
        
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        controller.dynamicDisposeBag = DisposeBag()
        controller.rx
            .sentMessage(#selector(UIViewController.viewDidAppear(_:))).map { _ in Void() }
            .subscribe(onNext: { [weak self, weak controller] in
                guard let self = self else { return }
                
                if let appearanceController = controller as? ViewControllerAppearanceManageable {
                    appearanceController.updateAppearance(self.navigationBar)
                } else {
                    self.updateAppearance(self.navigationBar)
                }
            })
            .disposed(by: controller.dynamicDisposeBag)
        
        controller.rx
            .sentMessage(#selector(UIViewController.viewWillAppear(_:))).map { _ in Void() }
            .subscribe(onNext: { [weak self, weak controller] in
                if let appearanceController = controller as? ViewControllerAppearanceManageable {
                    appearanceController.updateTabBarAppearance()
                } else {
                    self?.updateTabBarAppearance()
                }
            })
            .disposed(by: controller.dynamicDisposeBag)
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        var hidden = false
        if let controller = viewController as? ViewControllerAppearanceManageable {
            hidden = controller.navigationBarAppearance == .none
        }
        setNavigationBarHidden(hidden, animated: true)
    }
}
