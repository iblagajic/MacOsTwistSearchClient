//
//  UserDefaults+User.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 08/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import Foundation

extension UserDefaults {

    static let nameKey = "name"
    static let tokenKey = "token"
    static let idKey = "id"

    static func save(user: User) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(user.name, forKey: nameKey)
        userDefaults.setValue(user.token, forKey: tokenKey)
        userDefaults.setValue(user.id, forKey: idKey)
    }

    static var currentUser: User? {
        let userDefaults = UserDefaults.standard
        if let userName = userDefaults.string(forKey: nameKey),
            let userToken = userDefaults.string(forKey: tokenKey) {
            let userId = userDefaults.integer(forKey: idKey)
            return User(id: userId, token: userToken, name: userName)
        }
        return nil
    }
    
}
