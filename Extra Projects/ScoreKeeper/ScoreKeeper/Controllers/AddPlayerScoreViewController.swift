//
//  AddPlayerScoreViewController.swift
//  ScoreKeeper
//
//  Created by Justin Snider on 11/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit
import CoreData



class AddPlayerScoreViewController: UIViewController, ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    var score: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score)
        // Do any additional setup after loading the view.
    }
    @IBAction func scoreStepperTapped(_ sender: UIStepper) {
        score = Int(sender.value)
        scoreLabel.text = String(score)
    }
    
    //========================================
    //MARK: - Navigation
    //========================================

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
