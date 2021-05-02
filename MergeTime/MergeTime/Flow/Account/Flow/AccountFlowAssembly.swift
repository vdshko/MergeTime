//
//  AccountFlowAssembly.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import Swinject
import SwinjectAutoregistration

final class AccountFlowAssembly: Assembly {

    func assemble(container: Container) {
        container
            .autoregister(AccountModel.self, argument: NavigationNode.self, initializer: AccountModel.init)
            .inObjectScope(.transient)
        container
            .register(AccountViewController.self) { (resolver, node: NavigationNode) in
                AccountViewController(viewModel: AccountViewModel(model: resolver.autoresolve(argument: node)))
            }
            .inObjectScope(.transient)
    }
}
