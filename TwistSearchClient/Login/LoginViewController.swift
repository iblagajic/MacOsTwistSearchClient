//
//  LoginViewController.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 06/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import AppKit
import RxSwift
import RxCocoa

class LoginViewController: NSViewController {

    @IBOutlet weak var emailField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var loginButton: NSButton!

    var loginResult: Observable<LoginResult>?

    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.placeholderString = "Email"
        passwordField.placeholderString = "Password"
        loginButton.title = "Log in"
        let input = Observable.combineLatest(emailField.rx.text, passwordField.rx.text) { ($0, $1) }
        loginResult = loginButton.rx.tap
            .withLatestFrom(input)
            .flatMap(viewModel.login)
        #if DEBUG
            prefillFields()
        #endif
    }

    #if DEBUG
    func prefillFields() {
        if let path = Bundle.main.path(forResource: "Credentials", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            if let email = dict["email"] {
                emailField.stringValue = email
            }
            if let password = dict["password"] {
                passwordField.stringValue = password
            }
        }
    }
    #endif

}
