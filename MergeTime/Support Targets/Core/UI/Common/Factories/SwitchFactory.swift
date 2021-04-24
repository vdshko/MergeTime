//
//  SwitchFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class SwitchFactory: ViewFactory<UISwitch> {
    
    public func onTintColor(_ color: ColorAsset) -> Self {
        base.onTintColor = color.color
        
        return self
    }
}

extension UIFactory {

   public static func `switch`() -> SwitchFactory {
        return SwitchFactory()
    }
}
