//
//  NavigationService.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import AppKit
import RxSwift
import RxCocoa

class NavigationService {

    let mainWindow: NSWindow
    let mainController: NSWindowController

    let disposeBag = DisposeBag()

    init() {
        let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400),
                              styleMask: [.titled, .fullSizeContentView],
                              backing: .buffered,
                              defer: false)
        window.isMovableByWindowBackground = true
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.center()
        mainWindow = window
        window.title = "Twist"
        window.orderFrontRegardless()

        let controller = NSWindowController(window: window)
        mainController = controller

        let userDefaults = UserDefaults.standard
        if let userName = userDefaults.string(forKey: "name"),
            let userToken = userDefaults.string(forKey: "token") {
            let userId = userDefaults.integer(forKey: "id")
            let user = User(id: userId, token: userToken, name: userName)
            showSearch(for: user)
        } else {
            showLogin()
        }

        controller.showWindow(window)
    }

    private func showLogin() {
        let loginViewController = LoginViewController()
        mainWindow.contentViewController = loginViewController
        loginViewController.loginResult?
            .asDriver(onErrorJustReturn: LoginResult.error(err: LoginError.invalidResponse))
            .drive(onNext: { [weak self] result in
                switch result {
                case .success(let user):
                    self?.showSearch(for: user)
                case .error(let err):
                    self?.presentAlert(with: result.errorMessage ?? err.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    private func showSearch(for user: User) {
        let searchViewController = SearchViewController(for: user)
        mainWindow.contentViewController = searchViewController
        searchViewController.signOut?.asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.showLogin()
            }).disposed(by: disposeBag)
    }

    private func presentAlert(with message: String?) {
        let alert = NSAlert()
        if let message = message {
            alert.messageText = message
        }
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Ok")
        alert.runModal()
    }
}
