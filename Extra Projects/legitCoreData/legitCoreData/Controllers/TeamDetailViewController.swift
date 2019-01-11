//
//  ViewController.swift
//  legitCoreData
//
//  Created by Justin Snider on 1/11/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var team : Team?
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var playerTextField: UITextField!
    @IBOutlet weak var goalsTextField: UITextField!
    
    
    //========================================
    //MARK: - IBActions
    //========================================
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text,
            let player = playerTextField.text,
            let goals = goalsTextField.text,
            let goalsDouble = Double(goals) else { return }
        
        if let team = team {
            team.name = name
            team.favoritePlayer = player
            team.goalsScored = goalsDouble
        } else {
            TeamController.sharedController.createTeam(name: name, favoritePlayer: player, goalsScored: goalsDouble)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let team = team else { return }
        
        nameTextField.text = team.name
        playerTextField.text = team.favoritePlayer
        goalsTextField.text = String(team.goalsScored)
    }
}

