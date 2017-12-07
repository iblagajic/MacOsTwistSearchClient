//
//  Login.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 06/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import Foundation
import RxSwift

class Login {

    func login(withEmail email: String, password: String) -> Observable<LoginResult> {
        guard let url = URL(string: "https://staging.twistapp.com/api/v2/users/login") else {
            return Observable.just(.error(err: LoginError.invalidUrl))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params = "email=\(email)&password=\(password)"
        request.httpBody = params.data(using: String.Encoding.utf8)
        return URLSession.shared.rx.json(request: request)
            .map { response in
                if let dict = response as? [String:Any],
                    let user = User(with: dict) {
                    return .success(user: user)
                }
                return .error(err: LoginError.invalidResponse)
            }.catchError { error in
                Observable.just(LoginResult.error(err: error))
            }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }

}