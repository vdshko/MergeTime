//
//  UIView+Animation.swift
//  Core
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import UIKit

public enum AnimationStyle: String {
    
    case bounce
}

private extension AnimationStyle {
    
    enum Keys {
        
        static let transformScale = "transform.scale"
    }
    
    var animation: CAAnimation {
        switch self {
        case .bounce: return bounceAnimation()
        }
    }
    
    private func bounceAnimation() -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: Keys.transformScale)
        animation.values = [1.15, 0.85, 1.05, 0.95, 1]
        animation.duration = TimeInterval(0.4)
        animation.calculationMode = .cubic
        animation.isRemovedOnCompletion = true
        
        return animation
    }
}

public extension CALayer {
    
    func animate(with animationStyle: AnimationStyle) {
        add(animationStyle.animation, forKey: animationStyle.rawValue)
    }
}

public extension UIView {
    
    func animate(with animationStyle: AnimationStyle) {
        layer.animate(with: animationStyle)
    }
}
