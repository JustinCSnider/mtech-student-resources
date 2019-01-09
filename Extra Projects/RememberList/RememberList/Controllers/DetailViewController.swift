//
//  ViewController.swift
//  RememberList
//
//  Created by Justin Snider on 1/8/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var sentFrom: String?
    var currentMemory: Memory?
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var memoryTextField: UITextField!
    @IBOutlet weak var CRUDButton: UIButton!
    
    //========================================
    //MARK: - IBActions
    //========================================
    
    @IBAction func CRUDButtonTapped(_ sender: UIButton) {
        if sender.currentTitle == "Delete", let currentMemory = currentMemory {
            ContextHelper.context.delete(currentMemory)
            saveCurrentContext()
        } else if sender.currentTitle == "Save" {
            createMemory(name: memoryTextField.text ?? "")
        } else if sender.currentTitle == "Update" {
            currentMemory?.name = memoryTextField.text ?? ""
            saveCurrentContext()
        }
    }
    
    @IBAction func memoryTextFieldChanged(_ sender: UITextField) {
        updateUI()
    }
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentMemory = currentMemory {
            memoryTextField.text = currentMemory.name
        }
        updateUI()
        
        memoryTextField.becomeFirstResponder()
    }

    //========================================
    //MARK: - Helper Methods
    //========================================
    
    private func updateUI() {
        if sentFrom == "addSegue" {
            CRUDButton.setTitle("Save", for: .normal)
            if (memoryTextField.text ?? "").isEmpty {
                CRUDButton.isEnabled = false
            } else {
                CRUDButton.isEnabled = true
            }
        } else if sentFrom == "updateSegue" {
            if (memoryTextField.text ?? "").isEmpty {
                CRUDButton.setTitle("Delete", for: .normal)
            } else {
                CRUDButton.setTitle("Update", for: .normal)
            }
        } else {
            print("Something went wrong")
        }
    }
    
    //========================================
    //MARK: - Data Persistance Methods
    //========================================
    
    private func saveCurrentContext() {
        do {
            try ContextHelper.context.save()
        } catch {
            print("Failed to save")
            ContextHelper.context.rollback()
        }
    }
    
    private func createMemory(name: String) {
        let newMemory = NSEntityDescription.insertNewObject(forEntityName: Memory.entityName, into: ContextHelper.context) as! Memory
        newMemory.name = name
        
        do {
            try ContextHelper.context.save()
        } catch {
            print("Failed to save")
            ContextHelper.context.rollback()
        }
    }
}

