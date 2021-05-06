//
//  ModuleLevel.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

public enum ModuleLevel: Int, Comparable {
    
    case one = 1, two, three, four, five, six, seven, eight
    
    public static func < (lhs: ModuleLevel, rhs: ModuleLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
