//
//  LoginInspector.swift
//  Navigation
//
//  Created by t.lolaev on 16.01.2022.
//

import CurrentUserService

protocol LoginViewControllerDelegate {
    
    func checkCredentials(username: String, password: String) -> Bool
    
}

class LoginInspector: LoginViewControllerDelegate {
    
    public func checkCredentials(username: String, password: String) -> Bool {
        let checkerService = CheckerService.shared
        return checkerService.checkCredentials(username: username, password: password)
    }
    
}
