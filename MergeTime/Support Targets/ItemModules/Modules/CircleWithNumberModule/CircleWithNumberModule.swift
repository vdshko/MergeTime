//
//  CircleWithNumberModule.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 08.05.2021.
//

import class UIKit.UIView

final class CircleWithNumberModule: ItemModuleProtocol {
    
    let view: UIView
    let moduleType: ModuleType
    let moduleLevel: ModuleLevel
    let isDragging = BehaviorRelay<Bool>(value: false)
    let moveBackAction = PublishSubject<Void>()
    let maxLevel: ModuleLevel = .four
    
    init(level: ModuleLevel) {
        moduleLevel = min(level, maxLevel)
        self.view = CircleWithNumberView(with: moduleLevel.rawValue, isMaxLevel: moduleLevel == maxLevel)
        self.moduleType = .circleWithNumber
    }
}
