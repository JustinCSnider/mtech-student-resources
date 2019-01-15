//
//  Person.swift
//  fetchedResultsExample
//
//  Created by Justin Snider on 1/15/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class Person: NSManagedObject {
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var birthday: Date
    
    static var entityName: String { return "Person" }
}
