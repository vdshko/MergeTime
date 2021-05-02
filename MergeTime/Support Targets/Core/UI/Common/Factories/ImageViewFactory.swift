//
//  ImageViewFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class ImageViewFactory: ViewFactory<UIImageView> {
    
    // MARK: - Functions
    
    public func image(_ asset: ImageAsset) -> Self {
        base.image = asset.image
        
        return self
    }
}

extension UIFactory {

   public static func imageView() -> ImageViewFactory {
        return ImageViewFactory()
    }
}
