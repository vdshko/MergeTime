//
//  ItemModuleAssembly.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

public protocol ItemModuleAssemblyProtocol {
    
    func module(type: ModuleType, level: ModuleLevel) -> ItemModuleProtocol
    func nextLevel(for module: ItemModuleProtocol) -> ItemModuleProtocol?
}

public final class ItemModuleAssembly: ItemModuleAssemblyProtocol {
    
    public init() {}
    
    public func module(type: ModuleType, level: ModuleLevel) -> ItemModuleProtocol {
        switch type {
        case .squareWithNumber:
            return SquareWithNumberModule(level: level)
        }
    }
    
    public func nextLevel(for module: ItemModuleProtocol) -> ItemModuleProtocol? {
        guard let newLevel = ModuleLevel(rawValue: module.moduleLevel.rawValue + 1),
              newLevel <= module.maxLevel else {
            return nil
        }
        
        return self.module(type: module.moduleType, level: newLevel)
    }
}
