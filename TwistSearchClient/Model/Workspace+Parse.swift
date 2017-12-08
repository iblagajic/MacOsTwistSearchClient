//
//  Workspace+Parse.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import CoreData

extension Workspace {

    static func parse(response: Any, in context: NSManagedObjectContext) throws -> Workspace  {
        guard let array = response as? JSONArray,
            let first = array.first,
            let id = first["id"] as? Int32,
            let name = first["name"] as? String else {
                throw ParserError.workspaceParserError
        }

        let fetchRequest = NSFetchRequest<Workspace>(entityName: "Workspace")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        if let existingWorkspaces = try? context.fetch(fetchRequest),
            let existingWorkspace = existingWorkspaces.first {
            return existingWorkspace
        } else {
            let workspace = Workspace(context: context)
            workspace.id = id
            workspace.name = name
            return workspace
        }
    }
}
