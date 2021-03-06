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

        mainWindow = .standard
        mainController = NSWindowController(window: mainWindow)
        mainController.showWindow(mainWindow)

        if let user = UserDefaults.currentUser {
            showSearch(for: user)
        } else {
            showLogin()
        }
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

        searchViewController.signOut?
            .drive(onNext: { [weak self] in
                self?.showLogin()
            }).disposed(by: disposeBag)

        searchViewController.searchError?
            .drive(onNext: { [weak self] err in
                if let err = err {
                    self?.presentAlert(with: err.localizedDescription)
                }
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
