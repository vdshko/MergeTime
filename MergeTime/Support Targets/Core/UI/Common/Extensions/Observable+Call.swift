//
//  Observable+Call.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import Foundation
import RxSwift

extension ObservableType {
    
    /// calls given selector with each next value from current stream
    public func call<T: AnyObject>(_ object: T, _ selector: @escaping (T) -> () -> Void) -> Disposable {
        return subscribe(
            onNext: { [weak object] _ in
                if let `object` = object {
                    selector(object)()
                }
            },
            onError: nil,
            onCompleted: nil,
            onDisposed: nil
        )
    }
    
    /// calls given selector with each next value from current stream and passes the value
    public func call<T: AnyObject>(_ object: T, _ selector: @escaping (T) -> (Element) -> Any) -> Disposable {
        return subscribe(
            onNext: { [weak object] value in
                if let `object` = object {
                    _ = selector(object)(value)
                }
            },
            onError: nil,
            onCompleted: nil,
            onDisposed: nil
        )
    }
    
    /// calls given selector with additional parameter (warn: parameter is retained!)
    public func call2<T: AnyObject, P>(_ object: T, secondParameter: P, _ selector: @escaping (T) -> (Element, P) -> Void) -> Disposable {
        return subscribe(
            onNext: { [weak object] value in
                if let `object` = object {
                    selector(object)(value, secondParameter)
                }
            },
            onError: nil,
            onCompleted: nil,
            onDisposed: nil
        )
    }
}
