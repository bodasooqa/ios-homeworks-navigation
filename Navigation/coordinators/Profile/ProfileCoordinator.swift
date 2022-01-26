//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by t.lolaev on 25.01.2022.
//

import UIKit
import CurrentUserService

final class ProfileCoordinator: FinishCoordinator, Coordinator {
    
    private weak var navigationController: UINavigationController?
    
    private var userService: UserService?
    
    private var username: String
    
    var onFinish: (() -> Void)?
    
    init(navigationController: UINavigationController, username: String, userService: UserService) {
        self.navigationController = navigationController
        self.username = username
        self.userService = userService
    }
    
    func start() {
        guard let userService = userService else {
            return
        }

        navigationController?.pushViewController(ProfileViewController(username: username, userService: userService), animated: true)
        onFinish?()
    }
    
}
