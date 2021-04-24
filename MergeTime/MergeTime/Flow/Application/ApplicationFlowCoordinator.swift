//
//  ApplicationFlowCoordinator.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 18.04.2021.
//

import Swinject

final class ApplicationFlowCoordinator: NavigationNode, FlowCoordinator {
    
    var containerViewController: UIViewController?
    
    func createFlow() -> UIViewController {
        return UIViewController()
    }
}
