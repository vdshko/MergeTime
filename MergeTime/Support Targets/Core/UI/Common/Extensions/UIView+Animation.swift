//
//  UIView+Animation.swift
//  Core
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import UIKit

public enum AnimationStyle {
    
    case reverseAnimation(ReverseAnimation)
    case nonReverseAnimation(NonReverseAnimation)
}

public enum ReverseAnimation: String {
    
    case bounce
}

public enum NonReverseAnimation {
    
    case moveToPoint(point: CGPoint = .zero)
}

private extension ReverseAnimation {
    
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

private extension NonReverseAnimation {
    
    func animation(for layer: CALayer) {
        switch self {
        case .moveToPoint(let point): moveToPointAnimation(for: layer, point: point)
        }
    }
    
    private func moveToPointAnimation(for layer: CALayer, point: CGPoint) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            layer.frame.origin = .zero
        }
    }
}

public extension CALayer {
    
    func animate(with animationStyle: AnimationStyle) {
        switch animationStyle {
        case .reverseAnimation(let style): add(style.animation, forKey: style.rawValue)
        case .nonReverseAnimation(let style): style.animation(for: self)
        }
    }
}

public extension UIView {
    
    func animate(with animationStyle: AnimationStyle) {
        layer.animate(with: animationStyle)
    }
}
