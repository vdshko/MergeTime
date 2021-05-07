//
//  StoreroomFlowAssembly.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

import Swinject
import SwinjectAutoregistration
import class ItemModules.ItemModuleAssembly

final class StoreroomFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        assemblyServices(container)
        assemblyControllers(container)
    }
    
    private func assemblyServices(_ container: Container) {
        container
            .autoregister(ItemModuleAssemblyProtocol.self, initializer: ItemModuleAssembly.init)
            .inObjectScope(.transient)
    }
    
    private func assemblyControllers(_ container: Container) {
        container
            .autoregister(StoreroomModel.self, argument: NavigationNode.self, initializer: StoreroomModel.init)
            .inObjectScope(.transient)
        container
            .register(StoreroomViewController.self) { (resolver, node: NavigationNode) in
                StoreroomViewController(viewModel: StoreroomViewModel(model: resolver.autoresolve(argument: node), itemModuleAssembly: resolver.autoresolve()))
            }
            .inObjectScope(.transient)
    }
}
