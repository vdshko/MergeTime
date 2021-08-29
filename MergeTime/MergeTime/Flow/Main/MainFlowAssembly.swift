//
//  MainFlowAssembly.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 25.04.2021.
//

import Swinject
import SwinjectAutoregistration

final class MainFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        assembleTabBar(container)
        assembleCoordinators(container)
    }
    
    private func assembleTabBar(_ container: Container) {
        container
            .autoregister(TabBarController.self, initializer: TabBarController.init)
            .inObjectScope(.container)
    }
    
    private func assembleCoordinators(_ container: Container) {
        container
            .register(StoreroomFlowCoordinator.self) { [unowned container] (_, parent: NavigationNode) in
                StoreroomFlowCoordinator(container: container, parent: parent)
            }
            .inObjectScope(.container)
        container
            .register(RoadFlowCoordinator.self) { [unowned container] (_, parent: NavigationNode) in
                RoadFlowCoordinator(container: container, parent: parent)
            }
            .inObjectScope(.container)
        container
            .register(AccountFlowCoordinator.self) { [unowned container] (_, parent: NavigationNode) in
                AccountFlowCoordinator(container: container, parent: parent)
            }
            .inObjectScope(.container)
    }
}
