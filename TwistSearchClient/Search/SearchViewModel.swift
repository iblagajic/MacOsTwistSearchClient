//
//  SearchViewModel.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

class SearchViewModel {

    private let twist: Twist
    let searchText = PublishSubject<String>()
    let workspace: Observable<Workspace?>
    let searchResult: Observable<SearchQueryResult>

    init(for user: User) {
        self.twist = Twist(with: user)
        self.workspace = twist.getWorkspace()
        searchResult = searchText.flatMap(twist.search)
    }

    func lastSearchQuery() -> SearchQuery? {
        return twist.lastSearchQuery()
    }

    func signOut() -> Observable<Void> {
        return twist.signOut()
    }

}
