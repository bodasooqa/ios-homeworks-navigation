//
//  BaseCoordinator.swift
//  Navigation
//
//  Created by t.lolaev on 24.01.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    func start()
    
}

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

final class AppCoordinator: BaseCoordinator, Coordinator {
    
    private let navigationController = TabBarController(factory: MyLoginFactory())
    
    private let scene: UIWindowScene
    private var window: UIWindow?
    
    init(scene: UIWindowScene) {
        self.scene = scene
        super.init()
    }
    
    func start() {
        initWindow()
    }
    
    private func initWindow() {
        let window = UIWindow(windowScene: scene)
        window.backgroundColor = .white
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    private func startMainFlow() {
//        navigationController.setViewControllers([UIViewController]?, animated: <#T##Bool#>)
    }
    
}
