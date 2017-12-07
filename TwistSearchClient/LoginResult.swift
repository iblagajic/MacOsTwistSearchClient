//
//  LoginResult.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import RxCocoa

enum LoginResult {
    case success(user: User)
    case error(err: Error)

    var errorMessage: String? {
        switch self {
        case .error(let error):
            if let error = error as? RxCocoa.RxCocoaURLError {
                switch error {
                case .httpRequestFailed(_, let data):
                    if let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []),
                        let dict = json as? [String:Any],
                        let error = dict["error_string"] as? String {
                        return error
                    }
                    return error.localizedDescription
                default:
                    return error
                        .localizedDescription
                }
            }
        default:
            return nil
        }
        return nil
    }
}

enum LoginError: Error {
    case invalidUrl
    case invalidResponse
}
