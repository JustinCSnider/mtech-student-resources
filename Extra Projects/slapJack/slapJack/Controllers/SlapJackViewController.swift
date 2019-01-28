//
//  ViewController.swift
//  slapJack
//
//  Created by Justin Snider on 1/15/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit
import CoreData

class SlapJackViewController: UIViewController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    private var timer = Timer()
    private var resumeTapped = false
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    @IBOutlet weak var numberOfCardsTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var slapJackButton: UIButton!
    @IBOutlet weak var successfulSlapsLabel: UILabel!
    @IBOutlet weak var badSlapsLabel: UILabel!
    @IBOutlet weak var missedJacksLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var doneStackView: UIStackView!
    @IBOutlet weak var numberOfCardsView: UIView!
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var largePauseButton: UIButton!
    
    //========================================
    //MARK: - IBActions
    //========================================
    
    @IBAction func slapJackTapped(_ sender: UIButton) {
        
        sender.isEnabled = false
        self.pauseButton.isEnabled = true

        let cardController = CardController.sharedController

        cardController.orderedCards = []

        guard let deck = cardController.getDeck() else { fatalError() }

        scoreLabel.text = "Score: \(cardController.getScore())"
        numberOfCardsLabel.text = "\(deck.remaining)"
        numberOfCardsTitleLabel.isHidden = false
        
        displayNewCard()

        UIView.animate(withDuration: 1.0) {
            self.slapJackButton.alpha = 0.0
        }
        UIView.animate(withDuration: 1.5, animations: {
            self.cardImageView.alpha = 1.0
            self.numberOfCardsView.alpha = 1.0
            self.scoreLabel.alpha = 1.0
            self.pauseButton.alpha = 1.0
        }) { (_) in
            UIView.animate(withDuration: 2.0, animations: {
                self.numberOfCardsTitleLabel.isHidden = true
            })
        }
        runTimer()
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        guard let playFilled = UIImage(named: "largePlayFilled"),
            let pauseFilled = UIImage(named: "pauseFilled") else { return }
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.largePauseButton.setImage(playFilled, for: .highlighted)
            self.pauseButton.alpha = 0.0
            self.pauseView.alpha = 0.4
            self.largePauseButton.alpha = 1.0
        } else {
            runTimer()
            self.resumeTapped = false
            self.pauseButton.setImage(pauseFilled, for: .highlighted)
            self.pauseButton.alpha = 1.0
            self.pauseView.alpha = 0.0
            self.largePauseButton.alpha = 0.0
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        CardController.sharedController.shuffleDeck()
        
        
        sender.isEnabled = false
        slapJackButton.isEnabled = true
        UIView.animate(withDuration: 1.0) {
            self.doneStackView.alpha = 0.0
        }
        UIView.animate(withDuration: 2.0) {
            self.slapJackButton.alpha = 1.0
        }
        CardController.sharedController.getDeck()?.cards = nil
        CardController.sharedController.getDeck()?.remaining = 52
        CardController.sharedController.saveToPersistentStorage()
        CardController.sharedController.setDeck()
    }
    
    
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Slap Jack Button Setup
        slapJackButton.layer.cornerRadius = 5
        slapJackButton.layer.masksToBounds = true
        
        //Done Button Setup
        doneButton.layer.cornerRadius = 5
        doneButton.layer.masksToBounds = true
        
        //Number of cards Setup
        numberOfCardsView.layer.cornerRadius = 5
        numberOfCardsView.layer.borderWidth = 2.0
        numberOfCardsView.layer.borderColor = numberOfCardsView.tintColor.cgColor
        
        print(largePauseButton.contentMode.rawValue)
        print(cardImageView.contentMode.rawValue)

        //Logic for setting up view and animations
        CardController.sharedController.setDeck()
        
        guard let deck = CardController.sharedController.getDeck() else { return }
        
        let cardController = CardController.sharedController
        
        cardController.orderedCards = deck.cards?.allObjects as! [Card]
        
        if deck.remaining > 0, let imageURLString = cardController.orderedCards.last?.imageURL, let imageURL = URL(string: imageURLString) {
            //Setting up view if the user exited the game while it was still running
            resumeTapped = true
            
            scoreLabel.text = "Score: \(cardController.getScore())"
            numberOfCardsLabel.text = "\(deck.remaining)"
            showCardImage(url: imageURL)
            self.pauseButton.setImage(UIImage(named: "pauseFilled"), for: .highlighted)
            self.pauseView.alpha = 0.4
            self.largePauseButton.alpha = 1.0
            
            self.pauseButton.alpha = 1.0
            self.slapJackButton.alpha = 0.0
            self.cardImageView.alpha = 1.0
            self.numberOfCardsView.alpha = 1.0
            self.numberOfCardsTitleLabel.isHidden = true
            self.scoreLabel.alpha = 1.0
        } else if cardController.orderedCards != [] {
            //Setting up view if the user didn't press the done button after they were finished with their game
            successfulSlapsLabel.text = "\(cardController.getSuccessfullySlappedCards())"
            badSlapsLabel.text = "\(cardController.getBadSlappedCards())"
            missedJacksLabel.text = "\(cardController.getMissedJacks())"
            
            self.doneButton.isEnabled = true
            self.slapJackButton.alpha = 0.0
            self.doneStackView.alpha = 1.0
        }
    }
    
    //========================================
    //MARK: - Shake Functionality
    //========================================
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            CardController.sharedController.setScore()
            scoreLabel.text = "Score: \(CardController.sharedController.getScore())"
        }
    }

    //========================================
    //MARK: - Helper Methods
    //========================================
    
    @objc private func displayNewCard() {
        let cardController = CardController.sharedController
        
        guard let deck = cardController.getDeck() else { fatalError() }
        
        if deck.remaining > 0 {
            
            
            cardController.drawCard { (card) in
                if let card = card, let imageURL = URL(string: card.imageURL) {
                    
                    cardController.orderedCards.append(card)
                    
                    deck.cards = NSSet(array: cardController.orderedCards)
                    
                    self.showCardImage(url: imageURL)
                }
            }
            numberOfCardsLabel.text = "\(deck.remaining)"
            deck.remaining -= 1
            cardController.saveToPersistentStorage()
        } else {
            timer.invalidate()
            
            successfulSlapsLabel.text = "\(cardController.getSuccessfullySlappedCards())"
            badSlapsLabel.text = "\(cardController.getBadSlappedCards())"
            missedJacksLabel.text = "\(cardController.getMissedJacks())"
            
            self.doneButton.isEnabled = true
            self.pauseButton.isEnabled = false
            cardController.orderedCards = []
            UIView.animate(withDuration: 1.0, animations: {
                self.pauseButton.alpha = 0.0
                self.scoreLabel.alpha = 0.0
                self.numberOfCardsView.alpha = 0.0
                self.cardImageView.alpha = 0.0
            })
            UIView.animate(withDuration: 2.0) {
                self.doneStackView.alpha = 1.0
            }
        }
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(displayNewCard), userInfo: nil, repeats: true)
    }
    
    private func showCardImage(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.cardImageView.image = image
            }
        }.resume()
    }
}

