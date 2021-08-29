//
//  UIFont+Typography.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 25.04.2021.
//

import class UIKit.UIFont

extension UIFont {
    
    static func font(typography: Typography.Style) -> UIFont {
        return typography.font
    }
}
