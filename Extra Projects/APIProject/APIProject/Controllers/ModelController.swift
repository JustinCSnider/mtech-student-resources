//
//  ModelController.swift
//  APIProject
//
//  Created by Justin Snider on 12/12/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation

struct ModelController {
    
    static var currentItems: [Any] = []
    static var currentType: modelType = .randomUser
    
    enum modelType {
        case randomUser
        case representative
        case nobelWinner
    }
}
