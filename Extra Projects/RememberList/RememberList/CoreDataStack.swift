//
//  CoreDataStack.swift
//  RememberList
//
//  Created by Justin Snider on 1/8/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

struct ContextHelper {
    static var context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "MemoryList")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError()
            }
        })
        return container.viewContext
    }()
}
