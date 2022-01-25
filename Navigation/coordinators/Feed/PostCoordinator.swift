//
//  PostCoordinator.swift
//  Navigation
//
//  Created by t.lolaev on 25.01.2022.
//

import UIKit

final class PostCoordinator: Coordinator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let infoViewController = InfoViewController("Info")
        navigationController?.present(infoViewController, animated: true)
    }
    
}
