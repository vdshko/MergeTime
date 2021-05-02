//
//  UIEdgeInsets+Fabric.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public extension UIEdgeInsets {
    
    static func all(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: inset,
            left: inset,
            bottom: inset,
            right: inset
        )
    }
    
    static func vertical(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: inset,
            left: 0,
            bottom: inset,
            right: 0
        )
    }
    
    static func horizontal(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 0,
            left: inset,
            bottom: 0,
            right: inset
        )
    }
    
    static func top(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: 0, bottom: 0, right: 0)
    }
    
    static func bottom(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: inset, right: 0)
    }
    
    static func left(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
    }
    
    static func right(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: inset)
    }
    
    func vertical(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: inset,
            left: left,
            bottom: inset,
            right: right
        )
    }
    
    func horizontal(_ inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: top,
            left: inset,
            bottom: bottom,
            right: inset
        )
    }
}
