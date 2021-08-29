//
//  SquareWithNumberModule.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

import class UIKit.UIView
import struct UIKit.CGPoint

final class SquareWithNumberModule: ItemModuleProtocol, RepositoryTypeProtocol {
    
    var isMergedItem: Bool = false
    
    let view: UIView
    let moduleType: ModuleType = .squareWithNumber
    let moduleLevel: ModuleLevel
    let isDragging = BehaviorRelay<Bool>(value: false)
    let moveBackAction = PublishSubject<Void>()
    let moveToDirectPositionAction = PublishSubject<(position: CGPoint, completion: () -> Void)>()
    let maxLevel: ModuleLevel = .six
    let readyToEmitItems = BehaviorRelay<Bool>(value: true)
    let isSelected = BehaviorRelay<Bool>(value: false)
    
    init(level: ModuleLevel) {
        moduleLevel = min(level, maxLevel)
        view = SquareWithNumberView(with: moduleLevel.rawValue, isMaxLevel: moduleLevel == maxLevel)
    }
    
    func canEmitItems() -> Bool {
        return readyToEmitItems.value
    }
}
