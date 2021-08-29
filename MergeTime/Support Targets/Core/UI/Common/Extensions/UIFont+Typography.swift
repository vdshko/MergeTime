//
//  UIFont+Typography.swift
//  Core
//
//  Created by Vlad Shkodich on 25.04.2021.
//

import class UIKit.UIFont

public extension UIFont {
    
    static func font(typography: Typography.Style) -> UIFont {
        return typography.font
    }
}
