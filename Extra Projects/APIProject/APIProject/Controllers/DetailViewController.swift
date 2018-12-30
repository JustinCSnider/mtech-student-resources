//
//  DetailViewController.swift
//  APIProject
//
//  Created by Justin Snider on 12/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var randomUserStackView: UIStackView!
    @IBOutlet weak var randomUserThumbNail: UIImageView!
    @IBOutlet weak var randomUserFirstNameLabel: UILabel!
    @IBOutlet weak var randomUserLastNameLabel: UILabel!
    @IBOutlet weak var randomUserAgeLabel: UILabel!
    @IBOutlet weak var representativeStackView: UIStackView!
    @IBOutlet weak var representativeFullNameLabel: UILabel!
    @IBOutlet weak var representativeDistrictLabel: UILabel!
    @IBOutlet weak var representativePartyLabel: UILabel!
    @IBOutlet weak var representativePhoneLabel: UILabel!
    @IBOutlet weak var nobelWinnerStackView: UIStackView!
    @IBOutlet weak var nobelWinnerFullNameLabel: UILabel!
    @IBOutlet weak var nobelWinnerYearLabel: UILabel!
    @IBOutlet weak var nobelWinnerMotivationLabel: UILabel!
    @IBOutlet weak var nobelWinnerMotivationTextView: UITextView!
    
    var currentItem: Any?
    var selectedItem: Laureate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch ModelController.currentType {
        case .randomUser:
            randomUserCase()
        case .representative:
            representativeCase()
        case .nobelWinner:
            nobelWinnerCase()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        randomUserStackView.isHidden = true
        representativeStackView.isHidden = true
        nobelWinnerStackView.isHidden = true
    }
    
    func randomUserCase() {
        randomUserStackView.isHidden = false
        guard let currentItem = currentItem as? RandomUser else {return}
        navigationItem.title = currentItem.userName
        
        randomUserFirstNameLabel.text = "First Name: " + currentItem.firstName
        randomUserLastNameLabel.text = "Last Name: " + currentItem.lastName
        randomUserAgeLabel.text = "Age: " + String(currentItem.age)
        
        URLSession.shared.dataTask(with: currentItem.thumbNailURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.randomUserThumbNail.image = image
                }
            }
            }.resume()
    }
    
    func representativeCase() {
        representativeStackView.isHidden = false
        guard let currentItem = currentItem as? Representative else {return}
        navigationItem.title = "Representative in " + currentItem.state
        
        representativeFullNameLabel.text = "Full Name: " + currentItem.name
        representativeDistrictLabel.text = "District: " + currentItem.district
        representativePartyLabel.text = "Party: " + currentItem.party
        representativePhoneLabel.text = "Phone: " + currentItem.phone
    }
    
    func nobelWinnerCase() {
        nobelWinnerStackView.isHidden = false
        guard let currentItem = currentItem as? NobelWinner else {return}
        navigationItem.title = "Nobel Prize Winners of " + currentItem.year
        
        nobelWinnerFullNameLabel.text = "Full Name: " + (selectedItem?.firstName ?? "") + " " + (selectedItem?.surName ?? "")
        nobelWinnerYearLabel.text = "Year: " + currentItem.year
        if selectedItem?.motivation == "" {
            nobelWinnerMotivationLabel.isHidden = true
        } else {
            nobelWinnerMotivationLabel.isHidden = false
        }
        nobelWinnerMotivationTextView.text = (selectedItem?.motivation ?? "")
    }
}
