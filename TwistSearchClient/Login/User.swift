//
//  User.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 06/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

struct User {

    let id: Int
    let token: String
    let name: String

    init?(with payload: [String:Any]) {
        guard let id = payload["id"] as? Int,
            let token = payload["token"] as? String,
            let name = payload["name"] as? String else {
                return nil
        }
        self.id = id
        self.token = token
        self.name = name
    }
    
}
