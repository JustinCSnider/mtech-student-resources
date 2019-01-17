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
    
    var deck: Deck?
    
    //========================================
    //MARK: - Network Methods
    //========================================
    
    private func createNewDeck(completion: ((Deck?) -> Void)? = nil) {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1") else {
            print("Bad URL")
            return
        }
        
        
        NetworkController.performNetworkRequest(for: url) { (data, error) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            var results: Deck?
            
            if let deck = try? decoder.decode(Deck.self, from: data) {
                results = deck
            }
            
            if let completion = completion {
                completion(results)
            }
        }
    }
    
    func drawCard() {
        guard let deck = deck, let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deck.entity_id)/draw/?count=1") else {
            print("Bad URL")
            return
        }
        
        
        NetworkController.performNetworkRequest(for: url) { (data, error) in
            do {
                guard let data = data else { return }
                
                let decoder = JSONDecoder()
                
                let cards = try decoder.decode(Cards.self, from: data)
                deck.cards = NSSet(array: cards.cards)
            } catch {
                print(error)
            }
            self.saveToPersistentStorage()
            
        }
    }
    
    //========================================
    //MARK: - Data Persistence Methods
    //========================================
    
    private func saveToPersistentStorage() {
        do {
            try Stack.context.save()
        } catch {
            Stack.context.rollback()
            print("Save failed: \(error)")
        }
    }
    
    //========================================
    //MARK: - Helper Methods
    //========================================
    
    func setDeck() {
        let deckFetchRequest = NSFetchRequest<Deck>(entityName: Deck.entityName)
        
        do {
            if let coreDataDeck = try Stack.context.fetch(deckFetchRequest).first {
                deck = coreDataDeck
            } else {
                createNewDeck { (deck) in
                    guard let unwrappedDeck = deck else { return }
                    self.deck = unwrappedDeck
                    self.saveToPersistentStorage()
                }
            }
        } catch {
            print("Unable to fetch data from the context")
        }
    }
}
