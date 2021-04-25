//
//  TabBarController.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 25.04.2021.
//

import UIKit

public final class TabBarController: UITabBarController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        setupStyling()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override var viewControllers: [UIViewController]? {
        didSet { setupItems() }
    }
    
    public func select(tab: TabBarController.Items) {
        selectedIndex = tab.rawValue
    }
    
    private func setupStyling() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        tabBar.backgroundColor = Asset.Colors.Text.primary.color
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = Asset.Colors.Text.primary.color.cgColorDynamic
        tabBar.layer.shadowOpacity = 1
    }
    
    private func setupItems() {
        tabBar.tintColor = Asset.Colors.Background.primary.color
        tabBar.unselectedItemTintColor = Asset.Colors.Background.primary.color.withAlphaComponent(0.4)
        viewControllers?.enumerated().forEach { offset, controller in
            guard let tab = Items(rawValue: offset) else {
                return
            }
            
            controller.tabBarItem.image = tab.icon
            controller.tabBarItem.title = tab.title
            let attributes = [NSAttributedString.Key.font: UIFont.font(typography: .tabBarItem)]
            controller.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
            controller.tabBarItem.setTitleTextAttributes(attributes, for: .selected)
        }
    }
}

public extension TabBarController {
    
    enum Items: Int, CaseIterable {
        
        case storeroom, road, account
    }
}

extension TabBarController.Items {
    
    var icon: UIImage {
        let iconSize = CGSize(width: 34, height: 34)
        switch self {
        case .storeroom: return Asset.Assets.TapBar.storeroom.image.resize(to: iconSize)
        case .road: return Asset.Assets.TapBar.road.image.resize(to: iconSize)
        case .account: return Asset.Assets.TapBar.account.image.resize(to: iconSize)
        }
    }
    
    var title: String {
        switch self {
        case .storeroom: return L10n.tabBarStoreroom
        case .road: return L10n.tabBarRoad
        case .account: return L10n.tabBarAccount
        }
    }
}
