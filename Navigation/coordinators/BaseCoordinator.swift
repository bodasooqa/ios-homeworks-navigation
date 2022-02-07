//
//  BaseCoordinator.swift
//  Navigation
//
//  Created by t.lolaev on 24.01.2022.
//

import UIKit

class BaseCoordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard
            !childCoordinators.isEmpty,
            let coordinator = coordinator
        else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func removeAllDependencies() {
        childCoordinators.removeAll()
    }
    
}
