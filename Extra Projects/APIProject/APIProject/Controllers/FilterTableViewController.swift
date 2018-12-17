//
//  FilterTableViewController.swift
//  APIProject
//
//  Created by Justin Snider on 12/16/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

protocol newTypeDelegate {
    func newTypeSet(with title: String, placeHolderText: String)
}

class FilterTableViewController: UITableViewController {
    @IBOutlet weak var randomUserButton: UIButton!
    @IBOutlet weak var representativeButton: UIButton!
    @IBOutlet weak var nobelWinnerButton: UIButton!
    
    var delegate: newTypeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func FilterButtonTapped(_ sender: UIButton) {
        switch sender {
        case randomUserButton:
            ModelController.currentType = .randomUser
            delegate?.newTypeSet(with: "Random Users", placeHolderText: "Amount")
        case representativeButton:
            ModelController.currentType = .representative
            delegate?.newTypeSet(with: "Representatives", placeHolderText: "State")
        case nobelWinnerButton:
            ModelController.currentType = .nobelWinner
            delegate?.newTypeSet(with: "Nobel Prize Winners", placeHolderText: "Year")
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
