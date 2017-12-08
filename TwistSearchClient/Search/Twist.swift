//
//  Search.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import Foundation
import RxSwift

enum TwistError: Error {
    case invalidUrl
}

class Twist {

    static let baseUrl = "https://staging.twistapp.com/api/v2"
    
    private let token: String
    private let coreDataWrapper = CoreDataWrapper()

    init(with user: User) {
        self.token = user.token
        UserDefaults.save(user: user)
    }

    func getWorkspace() -> Observable<Workspace?> {
        guard let url = URL(string: "\(Twist.baseUrl)/workspaces/get") else {
            return Observable.error(TwistError.invalidUrl)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return URLSession.shared.rx.json(request: request)
            .observeOn(MainScheduler.instance)
            .map(coreDataWrapper.updateWorkspace)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }

    func search(query: String) -> Observable<SearchQueryResult> {
        if query.isEmpty {
            return Observable.empty()
        }
        guard let url = URL(string: "\(Twist.baseUrl)/search/query?query=\(query)") else {
            return Observable.error(TwistError.invalidUrl)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return URLSession.shared.rx.json(request: request)
            .observeOn(MainScheduler.instance)
            .map { [weak self] payload in
                let result = try self?.coreDataWrapper.updateSearchResults(withPayload: payload, for: query) ?? []
                return SearchQueryResult.success(result: result)
            }.catchError { error in
                Observable.just(SearchQueryResult.error(err: error))
            }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }

    func lastSearchQuery() -> SearchQuery? {
        return coreDataWrapper.fetchLastSearchQuery()
    }

    func signOut() -> Observable<Void> {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
        }
        return Observable.just(())
    }

}
