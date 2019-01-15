//
//  CoreDataStack.swift
//  fetchedResultsExample
//
//  Created by Justin Snider on 1/15/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

enum Stack {
    static var context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError()
            }
        })
        return container.viewContext
    }()
}
