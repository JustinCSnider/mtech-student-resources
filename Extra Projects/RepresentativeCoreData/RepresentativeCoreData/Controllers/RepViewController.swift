//
//  ViewController.swift
//  RepresentativeCoreData
//
//  Created by Justin Snider on 1/14/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class RepViewController: UIViewController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var representative: Representative? {
        return RepresentativeController.sharedController.representatives.first
    }
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
    
    //========================================
    //MARK: - Helper Methods
    //========================================
    
    func updateView() {
        if let rep = representative {
            nameLabel.text = "Name: \(rep.name)"
            addressLabel.text = "Address: \(rep.address)"
            phoneNumberLabel.text = "Phone Number: \(rep.phoneNumber)"
        } else {
            nameLabel.text = "Search for a Rep!"
            addressLabel.text = "Search for a Rep!"
            phoneNumberLabel.text = "Search for a Rep!"
            
        }
    }
}

