//
//  LoginViewModel.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

enum LoginValidationError: Error {
    case invalidInput
}

class LoginViewModel {

    private let login = Login()

    func login(withEmail email: String?, password: String?) -> Observable<LoginResult> {
        guard let email = email, !email.isEmpty,
            let password = password, !password.isEmpty else {
                return Observable.just(.error(err: LoginValidationError.invalidInput))
        }
        return login.login(withEmail: email, password: password)
    }
    
}
