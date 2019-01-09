//
//  Memory.swift
//  RememberList
//
//  Created by Justin Snider on 1/8/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class Memory: NSManagedObject {
    @NSManaged var name: String
    
    static var entityName: String {return "Memory"}
}
