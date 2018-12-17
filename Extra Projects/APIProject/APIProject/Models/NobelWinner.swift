//
//  NobelWinner.swift
//  APIProject
//
//  Created by Justin Snider on 12/12/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation

struct NobelWinner {
    
    var year: String
    var category: String
    var laureates: [laureate]
    
    struct laureate {
        var firstName: String
        var motivation: String
        var surName: String
        
        init?(json: [String : Any]) {
            
            guard let firstName = json["firstname"] as? String,
                let surName = json["surname"] as? String,
                let motivation = json["motivation"] as? String else {return nil}
            
            self.firstName = firstName
            self.surName = surName
            self.motivation = motivation
        }
    }
    
    init?(json: [String : Any]) {
        
        guard let year = json["year"] as? String,
            let category = json["category"] as? String,
            let laureates = json["laureates"] as? [laureate] else {return nil}
        
        self.year = year
        self.category = category
        self.laureates = laureates
    }
}
