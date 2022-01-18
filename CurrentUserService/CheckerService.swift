//
//  CheckerService.swift
//  CurrentUserService
//
//  Created by t.lolaev on 16.01.2022.
//

protocol CheckerServiceProtocol {
    
    func checkCredentials(username: String, password: String) -> Bool
    
}

public class CheckerService: CheckerServiceProtocol {
    
    public static let shared = CheckerService()
    
    private let username: String = "Hipster Cat"
    private let password: String = "12345"
    
    private let word: String = "hesoyam"
    
    private var usernameHash: Int {
        username.hash
    }
    
    private var passwordHash: Int {
        password.hash
    }
    
    public func checkCredentials(username: String, password: String) -> Bool {
        username.hash == usernameHash && password.hash == passwordHash
    }
    
    public func check(word: String) -> Bool {
        self.word == word
    }
    
}
