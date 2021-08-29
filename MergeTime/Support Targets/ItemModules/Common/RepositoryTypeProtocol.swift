//
//  RepositoryTypeProtocol.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 08.05.2021.
//

protocol RepositoryTypeProtocol {
    
    var readyToEmitItems: BehaviorRelay<Bool> { get }
}
