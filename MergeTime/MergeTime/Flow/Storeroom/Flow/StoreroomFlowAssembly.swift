//
//  StoreroomFlowAssembly.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

import Swinject
import SwinjectAutoregistration

final class StoreroomFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container
            .autoregister(StoreroomModel.self, argument: NavigationNode.self, initializer: StoreroomModel.init)
            .inObjectScope(.transient)
        container
            .register(StoreroomViewController.self) { (resolver, node: NavigationNode) in
                StoreroomViewController(viewModel: StoreroomViewModel(model: resolver.autoresolve(argument: node)))
            }
            .inObjectScope(.transient)
    }
}
