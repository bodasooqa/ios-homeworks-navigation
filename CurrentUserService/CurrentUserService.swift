//
//  CurrentUserService.swift
//  CurrentUserService
//
//  Created by t.lolaev on 12.01.2022.
//

public protocol UserService {
    
    func getUserByName(_ name: String) -> User?
    
}

public class CurrentUserService: UserService {
    
    private let currentUser: User = User(fullName: "Hipster Cat", avatar: "Cat", status: "I'm currently worked on!")
    
    public func getUserByName(_ name: String) -> User? {
        return name == currentUser.fullName ? currentUser : nil
    }
    
    public init() {}
    
}

public class TestUserService: UserService {
    
    private let currentUser: User = User(fullName: "Test", avatar: "Guest", status: "Test user")
    
    public func getUserByName(_ name: String) -> User? {
        return name == currentUser.fullName ? currentUser : nil
    }
    
    public init() {}
    
}
