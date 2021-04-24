//
//  PickerViewFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class PickerViewFactory<T>: ViewFactory<T> where T: UIPickerView { }

extension ViewFactory where T: StyledPickerView {
    
    public func text(_ color: ColorAsset) -> Self {
        base.setText(color.color)
        
        return self
    }
    
    public func text(_ color: ColorAsset, alpha: CGFloat) -> Self {
        base.setText(color.color.withAlphaComponent(alpha))
        
        return self
    }
    
    public func selector(_ color: ColorAsset) -> Self {
        base.selectorColor = color.color
        
        return self
    }
    
    public func selector(_ color: ColorAsset, alpha: CGFloat) -> Self {
        base.selectorColor = color.color.withAlphaComponent(alpha)
        
        return self
    }
}

extension UIFactory {

    public static func pickerView<T: UIPickerView>() -> PickerViewFactory<T> {
        return PickerViewFactory()
    }
}

public final class StyledPickerView: UIPickerView {
    
    var selectorColor: UIColor?

    public override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        
        setSelectedRowBackground()
    }
    
    fileprivate func setText(_ color: UIColor) {
        setValue(color, forKey: "textColor")
    }
    
    private func setSelectedRowBackground() {
        // by default, second subview is selector view
        guard subviews.count == 2,
              let color = selectorColor?.withAlphaComponent(0.5) else {
            return
        }
        
        subviews[1].backgroundColor = color
    }
}
