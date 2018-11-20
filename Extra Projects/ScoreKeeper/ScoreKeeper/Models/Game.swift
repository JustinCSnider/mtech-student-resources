//
//  Game.swift
//  ScoreKeeper
//
//  Created by Justin Snider on 11/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class Game: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var review: String?
    
    @NSManaged var players: NSSet?
    
    static var entityName: String {return "Game"}
}
