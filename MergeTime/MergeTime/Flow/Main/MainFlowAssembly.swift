//
//  MainFlowAssembly.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 25.04.2021.
//

import Swinject
import SwinjectAutoregistration
import class UI.TabBarController

final class MainFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container
            .autoregister(TabBarController.self, initializer: TabBarController.init)
            .inObjectScope(.transient)
    }
}
