//
//  TabBar.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let images = [
        UIImage(systemName: "house"),
        UIImage(systemName: "person.circle"),
        UIImage(systemName: "heart")
    ]
    
    init(controllers: [UINavigationController]) {
        super.init(nibName: nil, bundle: nil)
        
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
