//
//  TabBar.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    private var loginFactory: LoginFactory?
    
    private var controllers: [UINavigationController]?
    
    private let images = [
        UIImage(systemName: "house"),
        UIImage(systemName: "person.circle")
    ]
    
    init(factory: LoginFactory) {
        super.init(nibName: nil, bundle: nil)
        
        loginFactory = factory
        
        controllers = [
            UINavigationController(rootViewController: FeedViewController(with: .shared)),
            UINavigationController(rootViewController: LoginViewController(with: loginFactory!.getInspector(type: .login) as LoginViewControllerDelegate))
        ]
        
        setViewControllers(controllers, animated: false)
        tabBar.tintColor = UIColor(named: "MainColor")
        
        guard let tabItems = tabBar.items else {
            return
        }
        
        for (idx, tabItem) in tabItems.enumerated() {
            tabItem.image = images.compactMap { $0 }[idx]
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
