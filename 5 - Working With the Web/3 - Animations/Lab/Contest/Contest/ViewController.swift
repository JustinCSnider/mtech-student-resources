//
//  ViewController.swift
//  Contest
//
//  Created by Justin Snider on 11/29/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if emailTextField.text!.isEmpty {
            UIView.animate(withDuration: 0.1, animations: {
                self.emailTextField.transform = CGAffineTransform(translationX: 10, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.emailTextField.transform = CGAffineTransform(translationX: -20, y: 0)
                }) { (_) in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.emailTextField.transform = CGAffineTransform.identity
                    })
                }
            }
        } else {
            performSegue(withIdentifier: "success", sender: nil)
        }
    }
    
}

