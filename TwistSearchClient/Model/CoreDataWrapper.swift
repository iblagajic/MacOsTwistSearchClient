//
//  CoreDataWrapper.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import CoreData

class CoreDataWrapper {

    let persistentContainer: NSPersistentContainer

    init() {
        let container = NSPersistentContainer(name: "TwistSearchClient")
        container.loadPersistentStores() { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        self.persistentContainer = container
    }

    func updateWorkspace(withPayload payload: Any) throws -> Workspace {
        let workspace = try Workspace.parse(response: payload, in: persistentContainer.viewContext)
        save()
        return workspace
    }

    func save() {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
