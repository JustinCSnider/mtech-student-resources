//
//  TeamController.swift
//  legitCoreData
//
//  Created by Justin Snider on 1/11/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class TeamController {
    
    static let sharedController = TeamController()
    
    var teams = [Team]()
    
    func getMyTeams() {
        let teamFetchRequest = NSFetchRequest<Team>(entityName: Team.entityName)
        
        do {
            self.teams = try Stack.context.fetch(teamFetchRequest)
        } catch {
            self.teams = []
            print(error)
        }
    }
    
    func createTeam(name: String, favoritePlayer: String, goalsScored: Double) {
        let _ = Team(name: name, favoritePlayer: favoritePlayer, goalsScored: goalsScored)
        save()
    }
    
    func save() {
        do {
            try Stack.context.save()
        } catch {
            Stack.context.rollback()
            print(error)
        }
    }
    
    func delete(team: Team) {
        Stack.context.delete(team)
        save()
    }
}
