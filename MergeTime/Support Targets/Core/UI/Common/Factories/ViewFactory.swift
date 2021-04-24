//
//  ViewFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public class ViewFactory<T: UIView> {

    // MARK: - Constants
    
    public let base: T
    
    // MARK: - Constructors
    
    public init(base: T) {
        self.base = base
    }
    
    public convenience init() {
        self.init(base: T())
    }
    
    // MARK: - Functions
    
    public func background(_ color: ColorAsset) -> Self {
        base.backgroundColor = color.color
        
        return self
    }
    
    public func background(_ color: ColorAsset, alpha: CGFloat) -> Self {
        base.backgroundColor = color.color.withAlphaComponent(alpha)
        
        return self
    }
    
    public func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        base.contentMode = contentMode
        
        return self
    }
    
    public func cornerRadius(_ radius: CGFloat) -> Self {
        base.layer.cornerRadius = radius
        
        return self
    }
    
    public func clipsToBounds(_ clipsToBounds: Bool) -> Self {
        base.clipsToBounds = clipsToBounds
        
        return self
    }
    
    public func masksToBounds(_ masksToBounds: Bool) -> Self {
        base.layer.masksToBounds = masksToBounds
        
        return self
    }
    
    public func maskedCorners(_ maskedCorners: CACornerMask) -> Self {
        base.layer.maskedCorners = maskedCorners

        return self
    }
    
    public func border(color: ColorAsset, width: CGFloat = 1) -> Self {
        base.layer.borderColor = color.color.cgColor
        base.layer.borderWidth = width
        
        return self
    }
    
    public func tintColor(_ color: ColorAsset) -> Self {
        base.tintColor = color.color
        
        return self
    }
    
    public func tintColor(_ color: ColorAsset, alpha: CGFloat) -> Self {
        base.tintColor = color.color.withAlphaComponent(alpha)
        
        return self
    }
    
    public func isHidden(_ isHidden: Bool) -> Self {
        base.isHidden = isHidden
        
        return self
    }
    
    public func transform(_ transform: CGAffineTransform) -> Self {
        base.transform = transform
        
        return self
    }
    
    public func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        base.isUserInteractionEnabled = isUserInteractionEnabled
        
        return self
    }
    
    public func semanticContentAttribute(_ semanticContentAttribute: UISemanticContentAttribute) -> Self {
        base.semanticContentAttribute = semanticContentAttribute
        
        return self
    }
    
    public func build() -> T {
        return base
    }
}

extension UIFactory {
    
    public static func view<T: NiblessView>() -> ViewFactory<T> {
        return ViewFactory(base: T())
    }
}
