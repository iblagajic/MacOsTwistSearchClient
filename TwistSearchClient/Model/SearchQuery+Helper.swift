//
//  SearchQuery+Helper.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import CoreData

extension SearchQuery {

    static func get(query: String, context: NSManagedObjectContext) -> SearchQuery {
        let fetchRequest = NSFetchRequest<SearchQuery>(entityName: "SearchQuery")
        var searchQuery: SearchQuery
        if let existingQueries = try? context.fetch(fetchRequest),
            let firstQuery = existingQueries.first {
            if firstQuery.query == query {
                searchQuery = firstQuery
            } else {
                context.delete(firstQuery)
                searchQuery = SearchQuery(context: context)
                searchQuery.query = query
            }
        } else {
            searchQuery = SearchQuery(context: context)
            searchQuery.query = query
        }
        return searchQuery
    }

}
