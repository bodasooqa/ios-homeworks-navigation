//
//  UserModel.swift
//  CurrentUserService
//
//  Created by t.lolaev on 12.01.2022.
//

public struct User {
    
    public let fullName: String;
    public let avatar: String;
    public let status: String;
    
    public init(fullName: String, avatar: String, status: String) {
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
    
}
