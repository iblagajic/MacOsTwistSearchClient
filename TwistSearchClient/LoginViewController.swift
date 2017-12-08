//
//  LoginViewController.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 06/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import AppKit

class LoginViewController: NSViewController {

    @IBOutlet weak var emailField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var loginButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.placeholderString = "Email"
        passwordField.placeholderString = "Password"
        loginButton.title = "Log in"
    }

}
