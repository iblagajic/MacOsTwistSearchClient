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
        let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400), styleMask:[.titled, .closable], backing: .buffered, defer: false)
        let loginViewController = LoginViewController()
        window.contentViewController = loginViewController
        window.title = "Twist"
        window.orderFrontRegardless()
        mainWindow = window

        let controller = NSWindowController(window: window)
        controller.showWindow(window)
        mainController = controller

        loginViewController.loginResult?
            .drive(onNext: { [weak self] result in
                switch result {
                case .success(let user):
                    print("")
                    // TODO
                case .error(_):
                    self?.presentAlert(with: result.errorMessage)
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
