//
//  Representative.swift
//  RepresentativeCoreData
//
//  Created by Justin Snider on 1/14/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class Representative: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var phoneNumber: String
    
    static var entityName: String {return "Representative"}
    
    convenience init?(dictionary: Dictionary<String, Any>, context: NSManagedObjectContext = Stack.context) {
        self.init(context: context)
        guard let name = dictionary["name"] as? String,
            let phoneNumber = dictionary["phone"] as? String,
            let address = dictionary["office"] as? String else { return nil }
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
    }
}
