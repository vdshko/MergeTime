//
//  Typography.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import class UIKit.UIFont
import struct UIKit.CGFloat
import enum Resources.FontFamily

public final class Typography {
    
    public enum Style: CaseIterable {
        
        case `default`, tabBarItem, tiny
    }
}

public extension Typography.Style {
    
    var font: UIFont {
        switch self {
        case .default: return FontFamily.SFPro.regular.font(size: 18)
        case .tabBarItem: return FontFamily.SFPro.regular.font(size: 10)
        case .tiny: return FontFamily.SFPro.semibold.font(size: 8)
        }
    }
}

public extension Typography.Style {
    
    var lineHeightMultiple: CGFloat {
        switch self {
        default: return 1.0
        }
    }
}
