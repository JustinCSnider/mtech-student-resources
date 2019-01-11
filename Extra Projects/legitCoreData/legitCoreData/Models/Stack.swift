//
//  Stack.swift
//  legitCoreData
//
//  Created by Justin Snider on 1/11/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

enum Stack {
    static let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError()
            }
        })
        return container.viewContext
    }()
}
