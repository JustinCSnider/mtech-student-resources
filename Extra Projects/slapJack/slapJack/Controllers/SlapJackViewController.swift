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
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var slapJackButton: UIButton!
    
    //========================================
    //MARK: - IBActions
    //========================================
    
    @IBAction func slapJackTapped(_ sender: UIButton) {
        sender.isEnabled = false
        CardController.sharedController.drawCard()
        displayNewCard()
        scoreLabel.text = "Score: 0"
        numberOfCardsLabel.text = "Cards: 52"
        UIView.animate(withDuration: 1.0) {
            self.slapJackButton.alpha = 0.0
        }
        UIView.animate(withDuration: 2.0) {
            self.cardImageView.alpha = 1.0
            self.numberOfCardsLabel.alpha = 1.0
            self.scoreLabel.alpha = 1.0
            self.pauseButton.alpha = 1.0
        }
        runTimer()
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        guard let play = UIImage(named: "play"),
            let pause = UIImage(named: "pause"),
            let pauseFilled = UIImage(named: "pauseFilled"),
            let playFilled = UIImage(named: "playFilled") else { return }
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.imageView?.image = play
        } else {
            runTimer()
            self.resumeTapped = false
            self.pauseButton.imageView?.image = pause
        }
    }
    
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        slapJackButton.layer.cornerRadius = 5
        slapJackButton.layer.masksToBounds = true

        CardController.sharedController.setDeck()
    }
    
    //========================================
    //MARK: - Shake Functionality
    //========================================
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            CardController.sharedController.setScore()
            scoreLabel.text = "Score: \(CardController.sharedController.getScore())"
        }
    }

    //========================================
    //MARK: - Helper Methods
    //========================================
    
    @objc private func displayNewCard() {
        CardController.sharedController.drawCard()
        guard let imageURL = URL(string: (CardController.sharedController.getDeck().cards?.allObjects.last as! Card).imageURL) else { return }
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.cardImageView.image = image
            }
        }
        task.resume()
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(displayNewCard), userInfo: nil, repeats: true)
    }

}

