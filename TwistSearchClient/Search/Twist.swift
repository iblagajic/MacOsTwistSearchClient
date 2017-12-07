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

    private let token: String
    private let coreDataWrapper = CoreDataWrapper()

    init(with user: User) {
        self.token = user.token
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(user.name, forKey: "name")
        userDefaults.setValue(user.token, forKey: "token")
        userDefaults.setValue(user.id, forKey: "id")
    }

    func getWorkspace() -> Observable<Workspace?> {
        guard let url = URL(string: "https://staging.twistapp.com/api/v2/workspaces/get") else {
            return Observable.error(TwistError.invalidUrl)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return URLSession.shared.rx.json(request: request)
            .map(coreDataWrapper.updateWorkspace)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }

    func signOut() -> Observable<Void> {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
        }
        return Observable.just(())
    }

}
