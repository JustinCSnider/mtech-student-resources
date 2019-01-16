//
//  CardController.swift
//  slapJack
//
//  Created by Justin Snider on 1/15/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class CardController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    static var sharedController = CardController()
    
    var deck: Deck? {
        let deckFetchRequest = NSFetchRequest<Deck>(entityName: Deck.entityName)
        
        var finalDeck: Deck?
        
        do {
            if let coreDataDeck = try Stack.context.fetch(deckFetchRequest).first {
                finalDeck = coreDataDeck
            } else {
                createNewDeck { (decks) in
                    guard let unwrappedDeck = decks?.first else { return }
                    finalDeck = unwrappedDeck
                }
            }
            return finalDeck
        } catch {
            print("Unable to fetch data from the context")
            return nil
        }
    }
    
    //========================================
    //MARK: - Network Methods
    //========================================
    
    private func createNewDeck(completion: (([Deck]?) -> Void)? = nil) {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1") else {
            print("Bad URL")
            return
        }
        
        
        NetworkController.performNetworkRequest(for: url) { (data, error) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            var results = [Deck]()
            
            if let decks = try? decoder.decode(Decks.self, from: data) {
                results = decks.results
            }
            
            if let completion = completion {
                completion(results)
            }
        }
    }
}
