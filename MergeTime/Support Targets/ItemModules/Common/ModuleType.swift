//
//  ModuleType.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

// MARK: - Cases

public enum ModuleType: Equatable {
    
    case viewWithNumber(ModuleLevel)
}

// MARK: - Addition parameters

extension ModuleType {
    
    public var getNextLevel: ModuleType? {
        switch self {
        case .viewWithNumber(let level):
            guard let nextLevel = ModuleLevel(rawValue: level.rawValue + 1) else {
                return nil
            }
            
            return .viewWithNumber(nextLevel)
        }
    }
    
    public var level: Int {
        switch self {
        case .viewWithNumber(let level): return level.rawValue
        }
    }
}

public enum ModuleLevel: Int {
    
    case one = 1, two, three, four, five, six, seven, eight
}
