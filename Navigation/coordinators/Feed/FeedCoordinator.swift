//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by t.lolaev on 24.01.2022.
//

import UIKit
import StorageService

final class FeedCoordinator: BaseCoordinator, Coordinator {
    
    private weak var navigationController: UINavigationController?
    
    private var post: Post?
    
    init(navigationController: UINavigationController, post: Post) {
        self.navigationController = navigationController
        self.post = post
    }
    
    func start() {
        if let post = post {
            let postViewController = PostViewController(post: post)
            postViewController.onBarButtonTap = {
                self.showInfo()
            }
            
            navigationController?.pushViewController(postViewController, animated: true)
        }
    }
    
    private func showInfo() {
        guard let navigationController = navigationController else {
            return
        }

        let coordinator = PostCoordinator(navigationController: navigationController)
        addDependency(coordinator)
        coordinator.start()
    }
    
}
