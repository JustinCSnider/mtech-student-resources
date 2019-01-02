//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Justin Snider on 12/20/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
