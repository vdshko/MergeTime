//
//  StackViewFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public class StackViewFactory: ViewFactory<UIStackView> {
    
    // MARK: - Functions
    
    public func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        base.axis = axis
        
        return self
    }
    
    public func distribution(_ distribution: UIStackView.Distribution) -> Self {
        base.distribution = distribution
        
        return self
    }
    
    public func alignment(_ alignment: UIStackView.Alignment) -> Self {
        base.alignment = alignment
        
        return self
    }
    
    public func spacing(_ spacing: CGFloat) -> Self {
        base.spacing = spacing
        
        return self
    }
}

extension UIFactory {
    
    public static func stack() -> StackViewFactory {
        return StackViewFactory()
    }
}
