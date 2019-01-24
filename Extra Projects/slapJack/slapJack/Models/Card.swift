//
//  Card.swift
//  slapJack
//
//  Created by Justin Snider on 1/15/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class Card: NSManagedObject, Decodable {
    @NSManaged var imageURL: String
    @NSManaged var value: String
    @NSManaged var suit: String
    @NSManaged var wasSlapped: Bool
    @NSManaged var deck: Deck?
    
    static var entityName: String { return "Card" }
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image"
        case value
        case suit
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init(entity: NSEntityDescription.entity(forEntityName: Card.entityName, in: Stack.context)!, insertInto: Stack.context)
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL = try valueContainer.decode(String.self, forKey: CodingKeys.imageURL)
        self.value = try valueContainer.decode(String.self, forKey: CodingKeys.value)
        self.suit = try valueContainer.decode(String.self, forKey: CodingKeys.suit)
        self.wasSlapped = false
    }
}

struct Results: Decodable {
    let cards: [Card]
}
