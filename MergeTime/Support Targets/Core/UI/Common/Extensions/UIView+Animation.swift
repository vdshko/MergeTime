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
    case autoreverseSizingWithOpacity
    case smallBounce
}

public enum NonReverseAnimation {
    
    case moveToPoint(point: CGPoint = .zero, completion: (() -> Void)? = nil)
}

private extension ReverseAnimation {
    
    enum Keys {
        
        static let transformScale = "transform.scale"
        static let opacity = "opacity"
    }
    
    var animation: CAAnimation {
        switch self {
        case .bounce: return bounceAnimation()
        case .autoreverseSizingWithOpacity: return sizingWithOpacityAnimation()
        case .smallBounce: return smallBounceAnimation()
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
    
    private func sizingWithOpacityAnimation() -> CAAnimation {
        let transformScaleAnimation = CABasicAnimation(keyPath: Keys.transformScale)
        transformScaleAnimation.toValue = 1.04
        
        let opacityAnimation = CABasicAnimation(keyPath: Keys.opacity)
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.35
        
        let group = CAAnimationGroup()
        group.animations = [transformScaleAnimation, opacityAnimation]
        group.autoreverses = true
        group.duration = TimeInterval(1.5)
        group.repeatCount = .infinity
        
        return group
    }
    
    private func smallBounceAnimation() -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: Keys.transformScale)
        animation.values = [0.6, 1.3, 1.0]
        animation.duration = TimeInterval(0.3)
        animation.calculationMode = .cubic
        animation.isRemovedOnCompletion = true
        
        return animation
    }
}

private extension NonReverseAnimation {
    
    func animation(for layer: CALayer) {
        switch self {
        case let .moveToPoint(point, completion): moveToPointAnimation(for: layer, point: point, completion: completion)
        }
    }
    
    private func moveToPointAnimation(for layer: CALayer, point: CGPoint, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            layer.frame.origin = point
        } completion: { _ in
            completion?()
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
