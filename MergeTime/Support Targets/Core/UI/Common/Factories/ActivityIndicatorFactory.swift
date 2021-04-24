//
//  ActivityIndicatorFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class ActivityIndicatorFactory: ViewFactory<UIActivityIndicatorView> {
    
    public func style(_ style: UIActivityIndicatorView.Style) -> Self {
        base.style = style
        
        return self
    }
    
    public func color(_ color: ColorAsset) -> Self {
        base.color = color.color
        
        return self
    }
    
    public func hidesWhenStopped(_ hide: Bool) -> Self {
        base.hidesWhenStopped = hide
        
        return self
    }
}

extension UIFactory {

   public static func activityIndicator() -> ActivityIndicatorFactory {
        return ActivityIndicatorFactory()
    }
}
