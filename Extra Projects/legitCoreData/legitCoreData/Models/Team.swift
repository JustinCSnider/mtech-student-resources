//
//  Team.swift
//  legitCoreData
//
//  Created by Justin Snider on 1/11/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class Team : NSManagedObject {
    @NSManaged var name : String
    @NSManaged var favoritePlayer : String
    @NSManaged var goalsScored : Double
    @NSManaged var dateCreated : Date
    
    static var entityName : String {return "Team"}
    
    convenience init?(name: String, favoritePlayer: String, goalsScored: Double, context: NSManagedObjectContext = Stack.context) {
        self.init(context: context)
        self.name = name
        self.favoritePlayer = favoritePlayer
        self.goalsScored = goalsScored
        self.dateCreated = Date()
    }
}
