//
//  InfoViewController.swift
//  tabBar
//
//  Created by Justin Snider on 10/5/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet private var infoLabel: UILabel!
    
    func setInfo(with info: String) {
        self.loadViewIfNeeded()
        infoLabel.text = info
    }

}
