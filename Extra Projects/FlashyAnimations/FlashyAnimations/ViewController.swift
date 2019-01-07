//
//  ViewController.swift
//  FlashyAnimations
//
//  Created by Justin Snider on 1/4/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
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
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let label = createCenteredLabel(with: self.usernameTextField.text ?? "")
        UIView.animate(withDuration: 1, animations: {
            self.usernameTextField.alpha = 0.0
            self.emailTextField.alpha = 0.0
            self.submitButton.alpha = 0.0
        }) { (_) in
            UIView.animate(withDuration: 2.25, animations: {
                self.welcomeView.center.y += 150
                self.welcomeView.frame.size.height += 75
                self.welcomeView.transform = CGAffineTransform(scaleX: 1.1, y: 1)
            }) { (_) in
                UIView.animate(withDuration: 1, animations: {
                    label.alpha = 1.0
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
        
        usernameTextField.becomeFirstResponder()
    }
    
    //========================================
    //MARK: - Text Field Delegate Methods
    //========================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (usernameTextField.text ?? "").isEmpty {
            UIView.animate(withDuration: 0.1, animations: {
                self.usernameTextField.transform = CGAffineTransform(translationX: 10, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.usernameTextField.transform = CGAffineTransform(translationX: -20, y: 0)
                }) { (_) in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.usernameTextField.transform = CGAffineTransform.identity
                    })
                }
            }
        }
        
        if !isValid(emailTextField.text ?? "") {
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
        }
        
        if isValid(emailTextField.text ?? "") && !(usernameTextField.text ?? "").isEmpty {
            textField.resignFirstResponder()
            submitButtonTapped(textField)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == usernameTextField {
            let currentCharacterCount = textField.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount) {
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            return newLength <= 8
        } else {
            return true
        }
        
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
    
    private func createCenteredLabel(with string: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height))
        label.text = string
        label.font = label.font.withSize(50)
        label.adjustsFontSizeToFitWidth = true
        label.alpha = 0.0
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        self.view.addSubview(label)
        
        return label
    }
    
}
