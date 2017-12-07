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

    private let viewModel = LoginViewModel()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.placeholderString = "Email"
        passwordField.placeholderString = "Password"
        loginButton.title = "Log in"
        let input = Observable.combineLatest(emailField.rx.text, passwordField.rx.text) { ($0, $1) }
        loginButton.rx.tap
            .withLatestFrom(input)
            .flatMap(viewModel.login)
            .asDriver(onErrorJustReturn: LoginResult.error(err: LoginError.invalidResponse))
            .drive(onNext: { [weak self] result in
                switch result {
                case .success(let user):
                    print("user: \(user)") // TODO: open main
                case .error(_):
                    self?.presentAlert(with: result.errorMessage)
                }
            }).disposed(by: disposeBag)
    }

    func presentAlert(with message: String?) {
        let alert = NSAlert()
        if let message = message {
            alert.messageText = message
        }
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Ok")
        alert.runModal()
    }

}
