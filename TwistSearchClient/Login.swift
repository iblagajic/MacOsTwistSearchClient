//
//  Login.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 06/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import Foundation
import RxSwift

enum LoginError: Error {
    case invalidUrl
    case invalidResponse
}

class Login {

    func login(withEmail email: String, password: String) -> Observable<User> {
        guard let url = URL(string: "https://staging.twistapp.com/api/v2/users/login") else {
            return Observable.error(LoginError.invalidUrl)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params = "email=\(email)&password=\(password)"
        request.httpBody = params.data(using: String.Encoding.utf8)
        return URLSession.shared.rx.json(request: request)
            .flatMap { response -> Observable<User> in
                if let dict = response as? [String:Any],
                    let user = User(with: dict) {
                    return Observable.just(user)
                }
                return Observable.error(LoginError.invalidResponse)
            }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }

}
