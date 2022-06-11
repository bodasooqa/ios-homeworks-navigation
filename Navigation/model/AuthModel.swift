//
//  AuthModel.swift
//  Navigation
//
//  Created by t.lolaev on 06.06.2022.
//

import RealmSwift

public class AuthModel: Object {
    @Persisted public var email: String = ""
    @Persisted public var password: String = ""
}
