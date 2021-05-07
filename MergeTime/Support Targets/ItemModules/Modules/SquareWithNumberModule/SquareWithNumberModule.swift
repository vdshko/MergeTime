//
//  SquareWithNumberModule.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

import UIKit

final class SquareWithNumberModule: ItemModuleProtocol {
    
    let view: UIView
    let moduleType: ModuleType
    let moduleLevel: ModuleLevel
    let isDragging = BehaviorRelay<Bool>(value: false)
    let moveBackAction = PublishSubject<Void>()
    let maxLevel: ModuleLevel = .six
    
    init(level: ModuleLevel) {
        moduleLevel = min(level, maxLevel)
        self.view = SquareWithNumberView(with: moduleLevel.rawValue, isMaxLevel: moduleLevel == maxLevel)
        self.moduleType = .squareWithNumber
    }
}
