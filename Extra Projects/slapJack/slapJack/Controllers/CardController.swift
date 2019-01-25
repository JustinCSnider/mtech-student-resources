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
    private var score: Int = 0
    private var deck: Deck?
    var orderedCards = [Card]()
    
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
    
    func shuffleDeck() {
        guard let deck = deck, let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deck.entity_id)/shuffle/") else {
            print("Bad URL")
            return
        }
        
        NetworkController.performNetworkRequest(for: url) { (data, error) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            if let deck = try? decoder.decode(Deck.self, from: data) {
                self.deck = deck
            }
            
        }
    }
    
    func drawCard(completion: @escaping ((Card?) -> Void)) {
        guard let deck = deck, let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deck.entity_id)/draw/?count=1") else {
            print("Bad URL")
            return
        }
        
        
        NetworkController.performNetworkRequest(for: url) { (data, error) in
            do {
                guard let data = data else { return }
                
                let decoder = JSONDecoder()
                
                let results = try decoder.decode(Results.self, from: data)
                
                completion(results.cards.first)
            } catch {
                print(error)
            }
        }
    }
    
    //========================================
    //MARK: - Data Persistence Methods
    //========================================
    
    func saveToPersistentStorage() {
        do {
            try Stack.context.save()
        } catch {
            Stack.context.rollback()
            print("Save failed: \(error)")
        }
    }
    
    //========================================
    //MARK: - Getters and Setters
    //========================================
    
    
    //Deck
    func setDeck() {
        let deckFetchRequest = NSFetchRequest<Deck>(entityName: Deck.entityName)
        
        do {
            if let coreDataDeck = try Stack.context.fetch(deckFetchRequest).last {
                self.deck = coreDataDeck
            } else {
                createNewDeck { (deck) in
                    guard let unwrappedDeck = deck else { return }
                    self.deck = unwrappedDeck
                }
            }
        } catch {
            print("Unable to fetch data from the context")
        }
    }
    
    func getDeck() -> Deck? {
        guard let deck = deck else { return nil }
        return deck
    }
    
    
    //Score
    func setScore() {
        let count = orderedCards.count
        if self.orderedCards[count - 1].wasSlapped == false {
            if self.orderedCards[count - 1].value == "JACK" {
                score += 1
            } else {
                score -= 1
            }
        }
        orderedCards[count - 1].wasSlapped = true
        
        deck?.cards = NSSet(array: orderedCards)
    }
    
    func getScore() -> Int {
        return score
    }
    
    
    //Slapped Cards
    func getSuccessfullySlappedCards() -> Int {
        var slappedCards = 0
        for card in orderedCards {
            if card.wasSlapped == true && card.value == "JACK" {
                slappedCards += 1
            }
        }
        return slappedCards
    }
    
    func getBadSlappedCards() -> Int {
        var badSlaps = 0
        for card in orderedCards {
            if card.wasSlapped == true && card.value != "JACK" {
                badSlaps += 1
            }
        }
        return badSlaps
    }
    
    func getMissedJacks() -> Int {
        var missedJacks = 0
        for card in orderedCards {
            if card.value == "JACK" && card.wasSlapped == false {
                missedJacks += 1
            }
        }
        return missedJacks
    }
}
