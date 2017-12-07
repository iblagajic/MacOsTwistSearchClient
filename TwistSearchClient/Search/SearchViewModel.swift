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
    let workspace: Observable<Workspace?>

    init(for user: User) {
        self.twist = Twist(with: user)
        self.workspace = twist.getWorkspace()
    }

    func signOut() -> Observable<Void> {
        return twist.signOut()
    }
}
