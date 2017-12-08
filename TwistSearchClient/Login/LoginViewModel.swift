//
//  LoginViewModel.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

class LoginViewModel {

    let activityIndicator = ActivityIndicator()
    private let login = Login()

    func login(withEmail email: String?, password: String?) -> Observable<LoginResult> {
        guard let email = email, !email.isEmpty,
            let password = password, !password.isEmpty else {
                return Observable.just(.error(err: LoginError.invalidInput))
        }
        return login.login(withEmail: email, password: password)
            .trackActivity(activityIndicator)
    }
    
}
