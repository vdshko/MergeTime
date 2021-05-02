//
//  Resolver+Autoresolve.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 25.04.2021.
//

import Swinject

extension Resolver {

    func autoresolve<T>() -> T! {
        return resolve(T.self)
    }

    func autoresolve<T>(name: String) -> T! {
        return resolve(T.self, name: name)
    }

    func autoresolve<T, Arg1>(argument: Arg1) -> T! {
        return resolve(T.self, argument: argument)
    }
    
    func autoresolve<T>(argument: NavigationNode) -> T! {
        return resolve(T.self, argument: argument)
    }
    
    func autoresolve<T, Arg2>(arguments arg1: NavigationNode, _ arg2: Arg2) -> T! {
        return resolve(T.self, arguments: arg1, arg2)
    }
    
    func autoresolve<T>(argument: NavigationNode, name: String?) -> T! {
        return resolve(T.self, name: name, argument: argument)
    }
    
    func autoresolve<T, Arg2>(name: String?, arguments arg1: NavigationNode, _ arg2: Arg2) -> T! {
        return resolve(T.self, name: name, arguments: arg1, arg2)
    }
    
    func autoresolve<T, Arg2, Arg3>(arguments arg1: NavigationNode, _ arg2: Arg2, _ arg3: Arg3) -> T! {
        return resolve(T.self, arguments: arg1, arg2, arg3)
    }
    
    func autoresolve<T, Arg2, Arg3, Arg4>(arguments arg1: NavigationNode, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> T! {
        return resolve(T.self, arguments: arg1, arg2, arg3, arg4)
    }
}
