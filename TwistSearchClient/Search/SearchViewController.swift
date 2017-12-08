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

class SearchViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var signOutButton: NSButton!
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var tableView: NSTableView!

    var signOut: Observable<Void>?

    private var viewModel: SearchViewModel!
    private var searchResults: [SearchResult]? {
        didSet {
            tableView.reloadData()
        }
    }

    let disposeBag = DisposeBag()

    convenience init(for user: User) {
        self.init()
        self.viewModel = SearchViewModel(for: user)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signOutButton.title = "Sign out"
        tableView.gridColor = .lightGray
        tableView.gridStyleMask = .solidHorizontalGridLineMask
        viewModel.workspace.asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] workspace in
                if let name = workspace?.name {
                    self?.titleLabel.stringValue = name
                }
            }).disposed(by: disposeBag)
        signOut = signOutButton.rx.tap
            .flatMap(viewModel.signOut)
        searchField.rx.text.orEmpty.changed
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)

        viewModel.searchResult.asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] result in
                self?.searchResults = result
            }).disposed(by: disposeBag)
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return searchResults?.count ?? 0
    }

    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let identifier = NSUserInterfaceItemIdentifier(rawValue: "View")
        let searchResultView = tableView.makeView(withIdentifier: identifier, owner: nil) as? SearchResultView
        if let searchResults = searchResults {
            searchResultView?.update(with: searchResults[row])
        }
        return searchResultView
    }
    
}
