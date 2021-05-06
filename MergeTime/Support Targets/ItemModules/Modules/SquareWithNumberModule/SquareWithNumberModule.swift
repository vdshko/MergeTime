//
//  SquareWithNumberModule.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

import UIKit

public class SquareWithNumberModule: ItemModuleProtocol {
    
    public let view: UIView
    public let moduleType: ModuleType
    public let moduleLevel: ModuleLevel
    public let isDragging = BehaviorRelay<Bool>(value: false)
    public let moveBackAction = PublishSubject<Void>()
    public let maxLevel: ModuleLevel = .six
    
    public init(level: ModuleLevel) {
        moduleLevel = min(level, maxLevel)
        self.view = SquareWithNumberView(with: moduleLevel.rawValue)
        self.moduleType = .squareWithNumber
    }
}
