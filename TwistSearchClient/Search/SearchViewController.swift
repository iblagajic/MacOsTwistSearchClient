//
//  SearchViewController.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import AppKit
import RxSwift
import RxCocoa

class SearchViewController: NSViewController {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var signOutButton: NSButton!
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var tableView: NSTableView!

    var signOut: Observable<Void>?

    private var viewModel: SearchViewModel!

    let disposeBag = DisposeBag()

    convenience init(for user: User) {
        self.init()
        self.viewModel = SearchViewModel(for: user)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signOutButton.title = "Sign out"
        viewModel.workspace.asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] workspace in
                if let name = workspace?.name {
                    self?.titleLabel.stringValue = name
                }
            }).disposed(by: disposeBag)
        signOut = signOutButton.rx.tap
            .flatMap(viewModel.signOut)
    }
    
}
