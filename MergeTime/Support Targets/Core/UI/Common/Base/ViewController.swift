//
//  ViewController.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

open class ViewController<T>: UIViewController, ViewControllerAppearanceManageable where T: UIView {
    
    // MARK: - Appearance management
    
    open var navigationBarAppearance: NavigationBarAppearance { return .transparent }
    open var navigationBarTint: NavigationBarTint { return .black }
    open var tabBarIsHidden: Bool { return false }
    open var displayNavigationBarSeparator: Bool { return false }
    
    // MARK: - Root view setup
    
    // swiftlint:disable:next force_cast
    public var rootView: T { return view as! T }
    
    open override func loadView() {
        view = ViewFactory<T>().background(Asset.Colors.Background.primary).build()
        if displayNavigationBarSeparator {
            addNavigationItemBottomSeparator()
        }
    }
    
    // MARK: - Initialisations
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    required
    public init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
}
