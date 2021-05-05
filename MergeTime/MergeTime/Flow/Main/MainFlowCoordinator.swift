//
//  MainFlowCoordinator.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 25.04.2021.
//

import Swinject
import class UI.TabBarController

final class MainFlowCoordinator: NavigationFlowCoordinator {
    
    var containerViewController: UIViewController?
    
    private let container: Container
    
    init(container: Container, parent: NavigationNode) {
        self.container = Container(parent: container) { (container: Container) in
            MainFlowAssembly().assemble(container: container)
        }
        
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let controller: TabBarController = container.autoresolve()
        controller.viewControllers = TabBarController.Items.allCases.map { createViewController(for: $0) }
        controller.select(tab: .storeroom)
        containerViewController = controller
        
        return controller
    }
    
    private func createViewController(for tab: TabBarController.Items) -> UIViewController {
        switch tab {
        case .storeroom: return (container.autoresolve(argument: self) as StoreroomFlowCoordinator).createFlow()
        case .road: return (container.autoresolve(argument: self) as RoadFlowCoordinator).createFlow()
        case .account: return (container.autoresolve(argument: self) as AccountFlowCoordinator).createFlow()
        }
    }
}
