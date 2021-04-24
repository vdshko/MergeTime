//
//  NavigationBar+Appearance.swift
//  UI
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public enum NavigationBarAppearance: Int {
    
    case none       // remove navigation bar
    case transparent // transparent background (without line) with black back button arrow
    case white      // white background (without line) with black back button arrow
    
    var color: UIColor {
        switch self {
        case .transparent, .none: return .clear
        case .white: return .white
        }
    }
}

public enum NavigationBarTint {
    
    case black
    
    var color: UIColor {
        switch self {
        case .black: return .black
        }
    }
}

extension UINavigationBar {
    
    func updateNavigationBar(tint: NavigationBarTint = .black) {
        // back button color
        tintColor = tint.color
        titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
    }
    
    func setupNavigationBar() {
        // remove line
        let backgroundImage = UIImage()
        setBackgroundImage(backgroundImage, for: .default)

        shadowImage = UIImage()

        // back button image
        let image = UIImage()
        backIndicatorImage = image
        backIndicatorTransitionMaskImage = image
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -5), for: .default)
    }
}
