//
//  ObservableType+Unwrap.swift
//  Core
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import class RxSwift.Observable
import protocol RxSwift.ObservableType

public protocol Optionable {
    
    associatedtype Wrapped
    
    func isNil() -> Bool
    func unwrap(with defaultValue: Wrapped) -> Wrapped
    func forceUnwrap() -> Wrapped
}

extension Optional: Optionable {

    public func unwrap(with defaultValue: Wrapped) -> Wrapped {
        switch self {
        case .some(let value): return value
        case .none: return defaultValue
        }
    }
    
    public func forceUnwrap() -> Wrapped {
        switch self {
        case .some(let value): return value
        case .none: fatalError()
        }
    }
    
    public func isNil() -> Bool {
        switch self {
        case .some: return true
        case .none: return false
        }
    }
}

public extension ObservableType where Element: Optionable {
    
    func unwrap() -> Observable<Element.Wrapped> {
        return filter { !$0.isNil() }.map { $0.forceUnwrap() }
    }
    
    func unwrap(with defaultValue: Element.Wrapped) -> Observable<Element.Wrapped> {
        return map { $0.unwrap(with: defaultValue) }
    }
    
    func unwrap(with defaultValue: Observable<Element.Wrapped>) -> Observable<Element.Wrapped> {
        return Observable.combineLatest(self, defaultValue) { $0.unwrap(with: $1) }
    }
}
