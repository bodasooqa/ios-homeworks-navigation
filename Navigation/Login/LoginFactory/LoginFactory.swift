//
//  LoginFactory.swift
//  Navigation
//
//  Created by t.lolaev on 16.01.2022.
//

enum Inspector {
    case login
}

protocol LoginFactory {
    
    func getInspector(type: Inspector) -> LoginInspector
    
}

class MyLoginFactory: LoginFactory {
    
    func getInspector(type: Inspector) -> LoginInspector {
        switch type {
        case .login:
            return LoginInspector()
        }
    }
    
}
