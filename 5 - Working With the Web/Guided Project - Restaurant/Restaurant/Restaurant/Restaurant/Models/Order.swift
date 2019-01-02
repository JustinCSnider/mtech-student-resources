//
//  Order.swift
//  Restaurant
//
//  Created by Justin Snider on 12/20/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
