//
//  SquareWithNumberModule.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

import UIKit

final class SquareWithNumberModule: ItemModuleProtocol, RepositoryTypeProtocol {
    
    var isMergedItem: Bool = false
    
    let view: UIView
    let moduleType: ModuleType = .squareWithNumber
    let moduleLevel: ModuleLevel
    let isDragging = BehaviorRelay<Bool>(value: false)
    let moveBackAction = PublishSubject<Void>()
    let maxLevel: ModuleLevel = .six
    let readyToEmitItems = BehaviorRelay<Bool>(value: true)
    let isSelected = BehaviorRelay<Bool>(value: false)
    
    init(level: ModuleLevel) {
        moduleLevel = min(level, maxLevel)
        self.view = SquareWithNumberView(with: moduleLevel.rawValue, isMaxLevel: moduleLevel == maxLevel)
    }
    
    func canEmitItems() -> Bool {
        return readyToEmitItems.value
    }
}
