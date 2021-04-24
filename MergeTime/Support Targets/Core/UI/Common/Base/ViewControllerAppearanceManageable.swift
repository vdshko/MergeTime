//
//  ViewControllerAppearanceManageable.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public protocol ViewControllerAppearanceManageable: class {
    
    /// describes bar appearance; default is `black`
    var navigationBarAppearance: NavigationBarAppearance { get }
    /// describes bar tint; effects navigationBar.tintColor and status bar style; default is `white`
    var navigationBarTint: NavigationBarTint { get }
    /// determines whether tab bar should be hidden; default to `false`
    var tabBarIsHidden: Bool { get }
    /// manually trigger bar appearance update
    func updateAppearance(_ navigationBar: UINavigationBar?)
}

extension ViewControllerAppearanceManageable {
    
    public func updateAppearance(_ navigationBar: UINavigationBar?) {
        (self as? UIViewController)?.update(navigationBarAppearance: navigationBarAppearance)
        guard let `navigationBar` = navigationBar else {
            return
        }
        if !navigationBar.alreadySetup {
            navigationBar.setupNavigationBar()
            navigationBar.alreadySetup = true
        }
        navigationBar.updateNavigationBar(tint: navigationBarTint)
    }
    
    func updateTabBarAppearance() {
        (self as? UIViewController)?.tabBarController?.tabBar.isHidden = tabBarIsHidden
    }
    
    public func addNavigationItemBottomSeparator() {
        guard let navigationBarHolderView = (self as? UIViewController)?.navigationBarHolderView else {
            return
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .black
        navigationBarHolderView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: navigationBarHolderView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: navigationBarHolderView.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: navigationBarHolderView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

extension UIViewController {
    
    @nonobjc private static var AssociatedToken: UInt8 = 0
    
    private func navigationBarFrame() -> CGRect {
        let height: CGFloat
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first { (window: UIWindow) -> Bool in
                window.windowScene?.statusBarManager != nil
            }
            height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            height = UIApplication.shared.statusBarFrame.height
        }
        
        return CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: height + 44)
        )
    }
    
    fileprivate var navigationBarHolderView: UIView {
        if let view = (objc_getAssociatedObject(self, &UIViewController.AssociatedToken) as? UIView) {
            return view
        }
        
        let view = UIView(frame: navigationBarFrame())
        objc_setAssociatedObject(self, &UIViewController.AssociatedToken, view, .OBJC_ASSOCIATION_RETAIN)
        view.isUserInteractionEnabled = false
        self.view.addSubview(view)
        
        return view
    }
    
    fileprivate func update(navigationBarAppearance: NavigationBarAppearance) {
        guard navigationBarAppearance != .none else {
            return
        }
        
        let view = navigationBarHolderView
        view.frame = navigationBarFrame()
        view.backgroundColor = navigationBarAppearance.color
    }
}

extension UINavigationBar {
    
    @nonobjc private static var AssociatedToken: UInt8 = 15 >> 2
    
    fileprivate var alreadySetup: Bool {
        get {
            return (objc_getAssociatedObject(self, &UINavigationBar.AssociatedToken) as? Bool) ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &UINavigationBar.AssociatedToken, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
