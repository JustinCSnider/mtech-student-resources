//
//  Representative.swift
//  APIProject
//
//  Created by Justin Snider on 12/12/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation

struct Representative {
    
    var name: String
    var district: String
    var party: String
    var phone: String
    var state: String
    
    init?(json: [String : Any]) {
        guard let name = json["name"] as? String,
            let district = json["district"] as? String,
            let party = json["party"] as? String,
            let state = json["state"] as? String,
            let phone = json["phone"] as? String else {return nil}
        
        self.name = name
        self.district = district
        self.party = party
        self.phone = phone
        self.state = state
    }
}
