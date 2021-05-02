//
//  LabelFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class LabelFactory<T: UILabel>: ViewFactory<T> {
    
    private var text: String = ""
    private var lineHeightMultiple: CGFloat = 0
    
    // MARK: - Functions
    
    public func text(_ text: String) -> Self {
        self.text = text
        createAttributed()
        
        return self
    }
    
    public func lineHeightMultiple(_ lineHeightMultiple: CGFloat) -> Self {
        self.lineHeightMultiple = lineHeightMultiple
        createAttributed()
        
        return self
    }
    
    private func createAttributed() {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = base.textAlignment
        paragraphStyle.lineBreakMode = base.lineBreakMode
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )
        base.attributedText = attributedString
    }
    
    public func textColor(_ color: ColorAsset) -> Self {
        base.textColor = color.color
        
        return self
    }
    
    public func textColor(_ color: ColorAsset, alpha: CGFloat) -> Self {
        base.textColor = color.color.withAlphaComponent(alpha)
        
        return self
    }
    
    public func font(font name: String, size: CGFloat = 17) -> Self {
        base.font = UIFont(name: name, size: size)
        
        return self
    }
    
    public func font(typography: Typography.Style) -> Self {
        base.font = typography.font
        lineHeightMultiple = typography.lineHeightMultiple
        createAttributed()
        
        return self
    }
    
    public func textAlignment(_ alignment: NSTextAlignment) -> Self {
        base.textAlignment = alignment
        
        return self
    }
    
    public func numberOfLines(_ number: Int) -> Self {
        base.numberOfLines = number
        
        return self
    }
    
    public func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        base.lineBreakMode = lineBreakMode
        
        return self
    }
    
    public func textDropShadow() -> Self {
        base.layer.masksToBounds = false
        base.layer.shadowRadius = 2.0
        base.layer.shadowOpacity = 0.5
        base.layer.shadowOffset = CGSize(width: 1, height: 2)
        
        return self
    }
}

extension UIFactory {
    
    public static func label<T: UILabel>() -> LabelFactory<T> {
        return LabelFactory(base: T())
    }
}
