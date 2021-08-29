//
//  UIView+ApplyShadow.swift
//  Core
//
//  Created by Vlad Shkodich on 29.08.2021.
//

import UIKit

public extension UIView {
    
    func applyShadow(
        color: ColorAsset,
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 0,
        spread: CGFloat = 0
    ) {
        layer.applyShadow(color: color, alpha: alpha, x: x, y: y, blur: blur, spread: spread)
    }
}

public extension CALayer {
    
    func applyShadow(
        color: ColorAsset,
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 0,
        spread: CGFloat = 0
    ) {
        masksToBounds = false
        shadowColor = color.color.cgColorDynamic
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / UIScreen.main.scale
        let rect = spread == 0 ? bounds : bounds.insetBy(dx: -spread, dy: -spread)
        shadowPath = UIBezierPath(rect: rect).cgPath
    }
}
