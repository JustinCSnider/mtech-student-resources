//
//  MainTabBarViewController.swift
//  tabBar
//
//  Created by Justin Snider on 10/5/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let info = "My first language was java My first language was java My first language was java My first language was java My first language was java My first language was java My first language was java My first language was java"
        
        
        for child in self.children where child is InfoViewController {
            (child as! InfoViewController).setInfo(with: info)
        }
    }

}
