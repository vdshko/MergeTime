//
//  ItemModuleProtocol.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

import class UIKit.UIView

public protocol ItemModuleProtocol: AnyObject {
    
    var view: UIView { get }
    var moduleType: ModuleType { get }
    var moduleLevel: ModuleLevel { get }
    var isDragging: BehaviorRelay<Bool> { get }
    var moveBackAction: PublishSubject<Void> { get }
    
    func isEqual(to module: ItemModuleProtocol) -> Bool
    func isSameObject(to module: ItemModuleProtocol) -> Bool
}

public extension ItemModuleProtocol {
    
    func isEqual(to module: ItemModuleProtocol) -> Bool {
        return moduleType == module.moduleType && moduleLevel == module.moduleLevel
    }
    
    func isSameObject(to module: ItemModuleProtocol) -> Bool {
        return self === module
    }
}
