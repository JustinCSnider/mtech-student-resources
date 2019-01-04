//
//  ViewController.swift
//  FlashyAnimations
//
//  Created by Justin Snider on 1/4/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //========================================
    //MARK: - IBActions
    //========================================
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if isValid(emailTextField.text ?? "") && (usernameTextField.text ?? "") != "" {
            UIView.animate(withDuration: 1, animations: {
                self.usernameTextField.alpha = 0.0
                self.emailTextField.alpha = 0.0
                self.submitButton.alpha = 0.0
            }) { (_) in
                UIView.animate(withDuration: 3, animations: {
                    self.welcomeView.center.y += 150
                    self.welcomeView.frame.size.height += 75
                    self.welcomeView.transform = CGAffineTransform(scaleX: 1.1, y: 1)
                    var label = UILabel(frame: CGRect(x: self.welcomeView.center.x, y: self.welcomeView.center.y, width: 20, height: 20))
                    
                })
            }
        }
    }
    
    //========================================
    //MARK: - Life Cycle Methods
    //=========================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView.layer.cornerRadius = 5
        welcomeView.layer.masksToBounds = true
        
        submitButton.layer.cornerRadius = 5
        submitButton.layer.masksToBounds = true
    }
    
    //========================================
    //MARK: - Helper Methods
    //========================================
    
    private func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}
