//
//  TabBar.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let controllers = [
        UINavigationController(rootViewController: ProfileViewController()),
        UINavigationController(rootViewController: FeedViewController())
    ]
    
    private let images = [
        UIImage(systemName: "person.circle"),
        UIImage(systemName: "house")
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        
        setViewControllers(controllers, animated: false)
        
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
