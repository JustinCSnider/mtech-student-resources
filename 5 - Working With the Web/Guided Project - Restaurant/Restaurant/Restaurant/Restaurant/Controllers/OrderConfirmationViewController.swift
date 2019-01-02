//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Justin Snider on 1/1/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var minutes: Int!
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes"
    }
}
