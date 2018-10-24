//
//  ViewController.swift
//  AppEventCount
//
//  Created by Justin Snider on 10/24/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var didFinishLaunchingLabel: UILabel!
    @IBOutlet weak var didBecomeActiveLabel: UILabel!
    @IBOutlet weak var willResignActiveLabel: UILabel!
    @IBOutlet weak var willTerminateLabel: UILabel!
    @IBOutlet weak var didEnterBackgroundLabel: UILabel!
    @IBOutlet weak var willEnterForeGroundLabel: UILabel!
    
    var launchCount: Int = 0
    var didBecomeActiveCount: Int = 0
    var willResignActiveCount: Int = 0
    var willTerminateCount: Int = 0
    var didEnterBackgroundCount: Int = 0
    var willEnterForeGroundCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView() {
        didFinishLaunchingLabel.text = String(launchCount)
        didBecomeActiveLabel.text = String(didBecomeActiveCount)
        willResignActiveLabel.text = String(willResignActiveCount)
        willTerminateLabel.text = String(willTerminateCount)
        didEnterBackgroundLabel.text = String(didEnterBackgroundCount)
        willEnterForeGroundLabel.text = String(willEnterForeGroundCount)
        
        
    }


}

