//
//  TextFieldFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class TextFieldFactory: ViewFactory<UITextField> {
    
    private var lineHeightMultiple: CGFloat = 0
    
    // MARK: - Functions
    
    public func textColor(_ color: ColorAsset) -> Self {
        base.textColor = color.color
        
        return self
    }
    
    public func borderStyle(_ borderStyle: UITextField.BorderStyle) -> Self {
        base.borderStyle = borderStyle
        
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
    
    private func createAttributed() {
        let attributedString = NSMutableAttributedString(string: base.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = base.textAlignment
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )
        base.attributedText = attributedString
    }
    
    public func textAlignment(_ alignment: NSTextAlignment) -> Self {
        base.textAlignment = alignment
        
        return self
    }
    
    public func textDropShadow() -> Self {
        base.layer.masksToBounds = false
        base.layer.shadowRadius = 2.0
        base.layer.shadowOpacity = 0.5
        base.layer.shadowOffset = CGSize(width: 1, height: 2)
        
        return self
    }
    
    public func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        base.keyboardType = keyboardType
        
        return self
    }
    
    public func textContentType(_ textContentType: UITextContentType) -> Self {
        base.textContentType = textContentType
        
        return self
    }
    
    public func leftView(with size: CGSize) -> Self {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        paddingView.isUserInteractionEnabled = false
        base.leftView = paddingView
        
        return self
    }
    
    public func leftViewMode(_ mode: UITextField.ViewMode) -> Self {
        base.leftViewMode = mode
        
        return self
    }
}

extension UIFactory {

   public static func textField() -> TextFieldFactory {
        return TextFieldFactory()
    }
}
