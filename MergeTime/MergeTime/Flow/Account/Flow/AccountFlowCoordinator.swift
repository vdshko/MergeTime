//
//  AccountFlowCoordinator.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import Swinject
import class Core.NavigationController

final class AccountFlowCoordinator: NavigationFlowCoordinator {
    
    var containerViewController: UIViewController?
    
    private let container: Container
    
    init(container: Container, parent: NavigationNode?) {
        self.container = Container(parent: container) { (container: Container) in
            AccountFlowAssembly().assemble(container: container)
        }
        
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let controller: AccountViewController = container.autoresolve(argument: self)
        let navigationController = NavigationController(rootViewController: controller)
        containerViewController = navigationController
        
        return navigationController
    }
    
    // MARK: - Event handlers
    
    private func addHandlers() {
        addHandler { [weak self] (event: AccountEvent) in self?.handle(event) }
    }
    
    private func handle(_ event: AccountEvent) {}
}
