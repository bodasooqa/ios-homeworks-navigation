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
    
    private func makeWithRealm(callback: (_ realm: Realm) throws -> Void) {
        do {
            let realm = try Realm()
            try callback(realm)
        } catch let error {
            print(error)
        }
    }
    
    public func getAuthModel() -> Results<AuthModel>? {
        var result: Results<AuthModel>?
        makeWithRealm { realm in
            result = realm.objects(AuthModel.self)
        }
        
        return result
    }
    
    public func saveModel(_ model: Object) {
        makeWithRealm { realm in
            try realm.write({
                realm.add(model)
            })
        }
    }
    
}
