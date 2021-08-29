//
//  RoadFlowAssembly.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import Swinject
import SwinjectAutoregistration

final class RoadFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container
            .autoregister(RoadModel.self, argument: NavigationNode.self, initializer: RoadModel.init)
            .inObjectScope(.transient)
        container
            .register(RoadViewController.self) { (resolver, node: NavigationNode) in
                RoadViewController(viewModel: RoadViewModel(model: resolver.autoresolve(argument: node)))
            }
            .inObjectScope(.transient)
    }
}
