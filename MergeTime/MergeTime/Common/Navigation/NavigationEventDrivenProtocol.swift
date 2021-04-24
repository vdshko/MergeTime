//
//  NavigationEventDrivenProtocol.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 23.04.2021.
//

protocol NavigationEvent {}

protocol NavigationEventDrivenProtocol {
    
    func raise<T: NavigationEvent>(event: T)
    func addHandler<T: NavigationEvent>(_ handler: @escaping (T) -> Void)
}
