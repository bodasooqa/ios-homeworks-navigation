//
//  CheckerService.swift
//  CurrentUserService
//
//  Created by t.lolaev on 16.01.2022.
//

import FirebaseAuth
import Foundation

public typealias CheckCredentialsCallback = (AuthDataResult?, NSError?) -> Void

protocol CheckerServiceProtocol {
    
    func checkCredentials(username: String, password: String, callback: @escaping CheckCredentialsCallback) -> Void
    
}

public class CheckerService: CheckerServiceProtocol {
    
    public static let shared = CheckerService()
    
    private let auth = Auth.auth()
    
    private let username: String = "Hipster Cat"
    private let password: String = "12345"
    
    private let word: String = "hesoyam"
    
    private var usernameHash: Int {
        username.hash
    }
    
    private var passwordHash: Int {
        password.hash
    }
    
    // Please use .shared static prop
    private init() {}
    
    private func signInWithCredentials(email: String, password: String, callback: @escaping (Result<AuthDataResult, NSError>) -> Void) throws {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                callback(.failure(error))
            }
            
            if let authResult = authResult {
                callback(.success(authResult))
            }
        }
    }
    
    private func signUpWithCredentials(email: String, password: String, callback: @escaping (Result<AuthDataResult, NSError>) -> Void) throws {
        auth.createUser(withEmail: email, password: password) { createResult, error in
            if let error = error as? NSError {
                callback(.failure(error))
            }
            
            if let createResult = createResult {
                callback(.success(createResult))
            }
        }
    }
    
    public func checkCredentials(username: String, password: String, callback: @escaping CheckCredentialsCallback) -> Void {
        do {
            try signInWithCredentials(email: username, password: password) { result in
                self.handleResult(result, email: username, password: password, callback: callback)
            }
        } catch {
            self.handleError(error as NSError)
        }
    }
    
    private func handleResult(_ result: Result<AuthDataResult, NSError>, email: String, password: String, callback: @escaping CheckCredentialsCallback) {
        switch result {
        case .success(let user):
            callback(user, nil)
        case .failure(let error):
            self.handleError(error, email: email, password: password, callback: callback)
            callback(nil, error)
        }
    }
    
    private func handleError(_ error: NSError, email: String? = nil, password: String? = nil, callback: CheckCredentialsCallback? = nil) {
        let authError = AuthErrorCode(_nsError: error)
        
        switch authError.code {
        case .userNotFound:
            if let email = email, let password = password, let callback = callback {
                do {
                    try signUpWithCredentials(email: email, password: password) { result in
                        self.handleResult(result, email: email, password: password, callback: callback)
                    }
                } catch {
                    self.handleError(error as NSError)
                }
            }
        default:
            debugPrint(authError)
        }
    }
    
    public func check(word: String) -> Bool {
        self.word == word
    }
    
}
