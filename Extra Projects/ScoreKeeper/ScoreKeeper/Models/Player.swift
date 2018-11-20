//
//  Player.swift
//  ScoreKeeper
//
//  Created by Justin Snider on 11/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class Player: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var score: Int32
    
    @NSManaged var game: Game
    
    static var entityName: String {return "Player"}
}
