//
//  DataService.swift
//  ScoreKeeper
//
//  Created by Justin Snider on 11/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

struct DataService: ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext!
    
    func addGame(name: String, review: String?) {
        let newGame = NSEntityDescription.insertNewObject(forEntityName: Game.entityName, into: managedObjectContext) as! Game
        newGame.name = name
        newGame.review = review ?? ""
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Something went wrong \(error)")
            self.managedObjectContext.rollback()
        }
    }
    
    func addPlayer(name: String, score: Int32, game: Game) {
        let newPlayer = NSEntityDescription.insertNewObject(forEntityName: Player.entityName, into: managedObjectContext) as! Player
        newPlayer.name = name
        newPlayer.score = score
        newPlayer.game = game
        
        //game.players?.adding(newPlayer)
        
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Something went wrong \(error)")
            self.managedObjectContext.rollback()
        }
    }
    
}
