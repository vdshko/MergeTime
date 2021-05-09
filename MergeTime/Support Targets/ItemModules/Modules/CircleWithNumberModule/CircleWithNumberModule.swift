//
//  CircleWithNumberModule.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 08.05.2021.
//

import class UIKit.UIView
import struct UIKit.CGPoint

final class CircleWithNumberModule: ItemModuleProtocol {
    
    var isMergedItem: Bool = false
    
    let view: UIView
    let moduleType: ModuleType = .circleWithNumber
    let moduleLevel: ModuleLevel
    let isDragging = BehaviorRelay<Bool>(value: false)
    let moveBackAction = PublishSubject<Void>()
    let moveToDirectPositionAction = PublishSubject<(position: CGPoint, completion: () -> Void)>()
    let maxLevel: ModuleLevel = .four
    let isSelected = BehaviorRelay<Bool>(value: false)
    
    init(level: ModuleLevel) {
        moduleLevel = min(level, maxLevel)
        self.view = CircleWithNumberView(with: moduleLevel.rawValue, isMaxLevel: moduleLevel == maxLevel)
    }
}
