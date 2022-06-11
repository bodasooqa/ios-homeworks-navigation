//
//  RealmService.swift
//  Navigation
//
//  Created by t.lolaev on 06.06.2022.
//

import RealmSwift

public class RealmManager {
    
    public static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    public func getAuthModel() -> Results<AuthModel> {
        return localRealm.objects(AuthModel.self)
    }
    
    public func saveAuthModel(_ model: AuthModel) {
        try! localRealm.write({
            localRealm.add(model)
        })
    }
    
}
