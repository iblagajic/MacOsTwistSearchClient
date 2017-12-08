//
//  SearchQueryResult.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 08/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

enum SearchQueryResult {
    case success(result: [SearchResult])
    case error(err: Error)

    var errorValue: Error? {
        switch self {
        case .error(let err):
            return err
        default:
            return nil
        }
    }

    var resultValue: [SearchResult]? {
        switch self {
        case .success(let results):
            return results
        default:
            return nil
        }
    }
}
