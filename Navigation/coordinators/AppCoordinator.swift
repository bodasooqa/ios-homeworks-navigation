//
//  AppCoordinator.swift
//  Navigation
//
//  Created by t.lolaev on 24.01.2022.
//

import UIKit
import StorageService
import CurrentUserService

final class AppCoordinator: BaseCoordinator, Coordinator {
    
    private let scene: UIWindowScene
    private var window: UIWindow?
    
    private var tabBarController: TabBarController?
    private let navigationController = UINavigationController()
    
    private var feedViewController: FeedViewController?
    private var loginViewController: LoginViewController?
    private var favoritesViewController: FavoritesViewController?
    
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
        initViewControllers()
        
        if let feedViewController = feedViewController, let loginViewController = loginViewController, let favoritesViewController = favoritesViewController {
            tabBarController = TabBarController(controllers: [feedViewController, loginViewController, favoritesViewController].map({ controller in
                UINavigationController(rootViewController: controller)
            }))
        }
        
        guard let tabBarController = tabBarController else {
            return
        }
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    private func initViewControllers() {
        let loginFactory = MyLoginFactory()
        
        feedViewController = FeedViewController(with: .shared)
        loginViewController = LoginViewController(with: loginFactory.getInspector(type: .login) as LoginViewControllerDelegate)
        favoritesViewController = FavoritesViewController("Favorites")
        
        feedViewController?.onButtonTap = { post in
            self.showPost(post)
        }
        
        loginViewController?.onButtonTap = { username, userService in
            self.showProfile(username: username, userService: userService)
        }
    }
    
    func showPost(_ post: Post) {
        let coordinator = FeedCoordinator(navigationController: navigationController, post: post)
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showProfile(username: String, userService: UserService) {
        let coordinator = ProfileCoordinator(navigationController: navigationController, username: username, userService: userService)
        addDependency(coordinator)
        loginViewController?.coordinator = coordinator
        coordinator.start()
    }
    
}
