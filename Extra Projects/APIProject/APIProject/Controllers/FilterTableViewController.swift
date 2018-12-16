//
//  FilterTableViewController.swift
//  APIProject
//
//  Created by Justin Snider on 12/16/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    @IBOutlet weak var randomUserButton: UIButton!
    @IBOutlet weak var representativeButton: UIButton!
    @IBOutlet weak var nobelWinnerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func FilterButtonTapped(_ sender: UIButton) {
        switch sender {
        case randomUserButton:
            ModelController.currentType = .randomUser
        case representativeButton:
            ModelController.currentType = .representative
        case nobelWinnerButton:
            ModelController.currentType = .nobelWinner
        default:
            break
        }
        updateUI()
    }
    
    func updateUI() {
        switch ModelController.currentType {
        case .randomUser:
            randomUserButton.isSelected = true
            representativeButton.isSelected = false
            nobelWinnerButton.isSelected = false
        case .representative:
            representativeButton.isSelected = true
            nobelWinnerButton.isSelected = false
            randomUserButton.isSelected = false
        case .nobelWinner:
            nobelWinnerButton.isSelected = true
            representativeButton.isSelected = false
            randomUserButton.isSelected = false
        }
    }
    
}
