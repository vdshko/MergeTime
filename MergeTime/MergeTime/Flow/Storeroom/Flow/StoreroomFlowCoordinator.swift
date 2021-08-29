//
//  StoreroomFlowCoordinator.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

import Swinject
import class UI.NavigationController

final class StoreroomFlowCoordinator: NavigationFlowCoordinator {
    
    var containerViewController: UIViewController?
    
    private let container: Container
    
    init(container: Container, parent: NavigationNode?) {
        self.container = Container(parent: container) { (container: Container) in
            StoreroomFlowAssembly().assemble(container: container)
        }
        
        super.init(parent: parent)
        
        addHandlers()
    }
    
    func createFlow() -> UIViewController {
        let controller: StoreroomViewController = container.autoresolve(argument: self)
        let navigationController = NavigationController(rootViewController: controller)
        containerViewController = navigationController
        
        return navigationController
    }
    
    // MARK: - Event handlers
    
    private func addHandlers() {
        addHandler { [weak self] (event: StoreroomEvent) in self?.handle(event) }
    }
    
    private func handle(_ event: StoreroomEvent) {}
}
