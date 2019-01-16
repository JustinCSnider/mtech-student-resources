//
//  ViewController.swift
//  slapJack
//
//  Created by Justin Snider on 1/15/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class SlapJackViewController: UIViewController {
    
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
        slapJackButton.isEnabled = false
        UIView.animate(withDuration: 1.0) {
            self.slapJackButton.alpha = 0.0
            UIView.animate(withDuration: 2.0, animations: {
                self.cardImageView.alpha = 1.0
            })
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
        
        _ = CardController.sharedController.deck
    }


}

