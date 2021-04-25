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
        controller.viewControllers = createViewControllers()
        controller.select(tab: .road)
        containerViewController = controller
        
        return controller
    }
    
    private func createViewControllers() -> [UIViewController] {
        return [setupTestFirstScreen(with: .red), setupTestFirstScreen(with: .green), setupTestFirstScreen(with: .brown)]
    }
    
    // TBD: remove after finish setup
    
    private func setupTestFirstScreen(with backgroundColor: UIColor) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        controller?.view.backgroundColor = backgroundColor
        
        return controller ?? UIViewController()
    }
}
