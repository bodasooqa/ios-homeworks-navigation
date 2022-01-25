//
//  AppCoordinator.swift
//  Navigation
//
//  Created by t.lolaev on 24.01.2022.
//

import UIKit
import StorageService

final class AppCoordinator: BaseCoordinator, Coordinator {
    
    private let scene: UIWindowScene
    private var window: UIWindow?
    
    private var tabBarController: TabBarController?
    private let navigationController = UINavigationController()
    
    init(scene: UIWindowScene) {
        self.scene = scene
        super.init()
    }
    
    func start() {
        initWindow()
    }
    
    private func initWindow() {
        initTabBarController()
        
        let window = UIWindow(windowScene: scene)
        window.backgroundColor = .white
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    private func initTabBarController() {
        tabBarController = TabBarController(controllers: initViewControllers().map({ controller in
            UINavigationController(rootViewController: controller)
        }))
        
        guard let tabBarController = tabBarController else {
            return
        }
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    private func initViewControllers() -> [ViewController] {
        let loginFactory = MyLoginFactory()
        
        let feedViewController = FeedViewController(with: .shared),
            loginViewController = LoginViewController(with: loginFactory.getInspector(type: .login) as LoginViewControllerDelegate)
        
        feedViewController.onButtonTap = { post in
            self.showPost(post)
        }
        
        return [feedViewController, loginViewController]
    }
    
    func showPost(_ post: Post) {
        let coordinator = FeedCoordinator(navigationController: navigationController, post: post)
        addDependency(coordinator)
        coordinator.start()
    }
    
}
