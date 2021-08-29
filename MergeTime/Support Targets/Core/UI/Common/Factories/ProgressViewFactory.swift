//
//  ProgressViewFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class ProgressViewFactory: ViewFactory<UIProgressView> {
    
    public func progressTintColor(_ progressTintColor: ColorAsset, alpha: CGFloat = 1) -> Self {
        base.progressTintColor = progressTintColor.color.withAlphaComponent(alpha)
        
        return self
    }

    public func trackTintColor(_ trackTintColor: ColorAsset) -> Self {
        base.trackTintColor = trackTintColor.color
        
        return self
    }
}

extension UIFactory {

   public static func progressView() -> ProgressViewFactory {
        return ProgressViewFactory()
    }
}
