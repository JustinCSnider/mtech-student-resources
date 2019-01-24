//
//  Deck.swift
//  slapJack
//
//  Created by Justin Snider on 1/16/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class Deck: NSManagedObject, Decodable {
    @NSManaged var entity_id: String
    @NSManaged var remaining: Int16
    @NSManaged var cards: NSSet?
    
    static var entityName: String { return "Deck" }
    
    enum CodingKeys: String, CodingKey {
        case entity_id = "deck_id"
        case cards
        case remaining
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init(entity: NSEntityDescription.entity(forEntityName: Deck.entityName, in: Stack.context)!, insertInto: Stack.context)
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.entity_id = try valueContainer.decode(String.self, forKey: CodingKeys.entity_id)
        self.remaining = try valueContainer.decode(Int16.self, forKey: CodingKeys.remaining)
        if let cards = try? valueContainer.decode([Card].self, forKey: CodingKeys.cards) {
            self.cards = NSSet(array: cards)
        } else {
            self.cards = nil
        }
    }
}

