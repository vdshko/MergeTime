//
//  ButtonFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class ButtonFactory<T>: ViewFactory<T> where T: UIButton {
    
    public func title(_ title: String, state: UIControl.State = .normal) -> Self {
        base.setTitle(title, for: state)
        
        return self
    }
    
    public func titleColor(_ color: ColorAsset, alpha: CGFloat = 1, state: UIControl.State = .normal) -> Self {
        if alpha == 1 {
            base.setTitleColor(color.color, for: state)
        } else {
            base.setTitleColor(color.color.withAlphaComponent(alpha), for: state)
        }
        
        return self
    }
    
    public func isEnabled(_ isEnabled: Bool) -> Self {
        base.isEnabled = isEnabled
        
        return self
    }
    
    public func contentHorizontalAlignment(_ contentHorizontalAlignment: UIControl.ContentHorizontalAlignment) -> Self {
        base.contentHorizontalAlignment = contentHorizontalAlignment
        
        return self
    }
    
    public func numberOfLines(_ number: Int) -> Self {
        base.titleLabel?.numberOfLines = number
        
        return self
    }
    
    public func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        base.titleLabel?.lineBreakMode = lineBreakMode
        
        return self
    }
    
    public func addTarget(_ target: Any?, action: Selector, for event: UIControl.Event) -> Self {
        base.addTarget(target, action: action, for: event)
        
        return self
    }
    
    public func titleEdgeInsets(_ insets: UIEdgeInsets) -> Self {
        base.titleEdgeInsets = insets
        
        return self
    }
    
    public func textAlignment(_ alignment: NSTextAlignment) -> Self {
        base.titleLabel?.textAlignment = alignment
        
        return self
    }
    
    public func image(_ image: ImageAsset, state: UIControl.State = .normal) -> Self {
        base.setImage(image.image, for: state)
    
        return self
    }
    
    public func setBackgroundImage(_ image: ImageAsset, state: UIControl.State = .normal, alignmentRectInsets: UIEdgeInsets? = nil) -> Self {
        if let insets = alignmentRectInsets {
            base.setBackgroundImage(image.image.withAlignmentRectInsets(insets), for: state)
        } else {
            base.setBackgroundImage(image.image, for: state)
        }
        
        return self
    }
    
    public func imageEdgeInsets(_ insets: UIEdgeInsets) -> Self {
        base.imageEdgeInsets = insets
        
        return self
    }
    
    public func imageViewContentMode(_ contentMode: UIView.ContentMode) -> Self {
        base.imageView?.contentMode = contentMode
        
        return self
    }
}

extension UIFactory {
    
    public static func button<T: UIButton>(type: UIButton.ButtonType = .system) -> ButtonFactory<T> {
        return ButtonFactory(base: T(type: type))
    }
}

extension UIColor {
    
    public var cgColorDynamic: CGColor {
        guard #available(iOS 13.0, *),
              let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first else {
            return self.cgColor
        }
        
        return self.resolvedColor(with: keyWindow.traitCollection).cgColor
    }
}
