//
//  ApplicationFlowAssembly.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 25.04.2021.
//

import Swinject
import SwinjectAutoregistration

final class ApplicationFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container
            .register(MainFlowCoordinator.self) { [unowned container] (_, parent: NavigationNode) in
                MainFlowCoordinator(container: container, parent: parent)
            }
            .inObjectScope(.transient)
    }
}
