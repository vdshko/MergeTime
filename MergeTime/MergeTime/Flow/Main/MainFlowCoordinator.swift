//
//  MainFlowCoordinator.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 25.04.2021.
//

import Swinject

final class MainFlowCoordinator: NavigationFlowCoordinator {
    
    var containerViewController: UIViewController?
    
    init(container: Container, parent: NavigationNode) {
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        return setupTestFirstScreen()
    }
    
    // TBD: remove after finish setup
    
    private func setupTestFirstScreen() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        return controller ?? UIViewController()
    }
}
