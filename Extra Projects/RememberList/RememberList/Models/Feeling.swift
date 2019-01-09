//
//  Feeling.swift
//  RememberList
//
//  Created by Justin Snider on 1/9/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class Feeling: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var memory: Memory
    
    static var entityName: String { return "Feeling"}
}
