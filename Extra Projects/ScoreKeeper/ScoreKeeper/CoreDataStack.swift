//
//  CoreDataStack.swift
//  ScoreKeeper
//
//  Created by Justin Snider on 11/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation
import CoreData


func createManagedObjectContext(completion: @escaping (NSPersistentContainer) -> Void){
    
    let container = NSPersistentContainer(name: "Games")
    
    // Happens asynchronously
    container.loadPersistentStores { (persistentStoreDescription, error) in
        
        guard error == nil else {fatalError("Something went wrong.")}
        
        DispatchQueue.main.async {
            completion(container)
        }
    }
    
}

