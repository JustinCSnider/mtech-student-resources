//
//  DetailViewController.swift
//  APIProject
//
//  Created by Justin Snider on 12/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var currentItem: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        switch ModelController.currentType {
        case .randomUser:
            guard let currentItem = currentItem as? RandomUser else {return}
            navigationItem.title = currentItem.userName
            
            firstNameLabel.text = "First Name: " + currentItem.firstName
            lastNameLabel.text = "Last Name: " + currentItem.lastName
            ageLabel.text = "Age: " + String(currentItem.age)
            
            URLSession.shared.dataTask(with: currentItem.thumbNailURL) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.thumbNail.image = image
                    }
                }
            }.resume()
        case .representative:
            break
        case .nobelWinner:
            break
        }
        // Do any additional setup after loading the view.
    }
}
