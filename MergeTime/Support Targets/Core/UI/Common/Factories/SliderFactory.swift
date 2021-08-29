//
//  SliderFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class SliderFactory: ViewFactory<UISlider> {
    
    // MARK: - Constructor
    
    public override init(base: UISlider) {
        super.init(base: base)
        
        base.isUserInteractionEnabled = true
        base.isContinuous = true
    }
    
    // MARK: - Functions
    
    public func value(_ value: Float) -> Self {
        base.value = value
        
        return self
    }
    
    public func minValue(_ minValue: Float) -> Self {
        base.minimumValue = minValue
        
        return self
    }
    
    public func thumbImage(_ image: ImageAsset, state: UIControl.State = .normal) -> Self {
        base.setThumbImage(image.image, for: state)
        
        return self
    }
    
    public func thumbTint(_ color: ColorAsset) -> Self {
        base.thumbTintColor = color.color

        return self
    }
    
    public func maxValue(_ maxValue: Float) -> Self {
        base.maximumValue = maxValue
        
        return self
    }
    
    public func minimumTrackTintColor(_ color: ColorAsset, alpha: CGFloat = 1) -> Self {
        base.minimumTrackTintColor = color.color.withAlphaComponent(alpha)
        
        return self
    }
    
    public func maximumTrackTintColor(_ color: ColorAsset, alpha: CGFloat = 1) -> Self {
        base.maximumTrackTintColor = color.color.withAlphaComponent(alpha)
        
        return self
    }
}

extension UIFactory {
    
    public static func slider() -> SliderFactory {
        return SliderFactory()
    }
}
