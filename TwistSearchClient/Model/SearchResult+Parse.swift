//
//  SearchResult+Parse.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import CoreData

extension SearchResult {

    static func parse(response: Any, in context: NSManagedObjectContext, for query: SearchQuery) throws -> [SearchResult]  {
        guard let result = response as? JSONDictionary,
            let items = result["items"] as? JSONArray else {
                throw ParserError.searchResultParserError
        }

        let results = items.flatMap { item -> SearchResult? in
            guard let id = item["id"] as? String else {
                    return nil
            }

            let ids = items.flatMap { $0["id"] as? String }
            let existingResultsIndexed = existingResults(for: ids, inContext: context)

            var searchResult: SearchResult
            if let existingResult = existingResultsIndexed[id] {
                searchResult = existingResult
            } else {
                searchResult = SearchResult(context: context)
            }

            searchResult.id = id
            searchResult.details_link = item["details_link"] as? String
            if let lastPostedTs = item["last_posted_ts"] as? Int32 {
                searchResult.last_posted_ts = lastPostedTs
            }
            searchResult.snippet = item["snippet"] as? String
            searchResult.title = item["title"] as? String
            searchResult.addToQuery(query)

            return searchResult
        }

        return results
    }

    static func existingResults(for ids: [String], inContext context: NSManagedObjectContext) -> [String:SearchResult] {
        let fetchRequest = NSFetchRequest<SearchResult>(entityName: "SearchResult")
        fetchRequest.predicate = NSPredicate(format: "id in %@", ids)
        
        let existingResults = try? context.fetch(fetchRequest)
        var existingResultsIndexed = [String : SearchResult]()
        for result in existingResults ?? [] {
            if let id = result.id {
                existingResultsIndexed[id] = result
            }
        }
        return existingResultsIndexed
    }

}
