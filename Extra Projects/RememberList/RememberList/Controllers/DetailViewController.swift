//
//  ViewController.swift
//  RememberList
//
//  Created by Justin Snider on 1/8/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit
import CoreData

protocol addFeelingDelegate {
    func addFeeling(name: String)
}

class DetailViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, addFeelingDelegate {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var sentFrom: String?
    var currentMemory: Memory?
    
    var memory: Memory? {
        
//        ContextHelper.context
        return nil
    }
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var memoryTextField: UITextField!
    @IBOutlet weak var CRUDButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
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
            tableView.isUserInteractionEnabled = true
        }
        updateUI()
        
        memoryTextField.becomeFirstResponder()
        
        CRUDButton.layer.cornerRadius = 5
        CRUDButton.layer.masksToBounds = true
        
        tableView.layer.cornerRadius = 5
        tableView.layer.borderWidth = 1.0
    }
    
    //========================================
    //MARK: - Table View Delegate/Data Methods
    //========================================
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            let addNewFeelingCell = tableView.dequeueReusableCell(withIdentifier: "addNewFeelingCell", for: indexPath) as! addNewFeelingTableViewCell
            addNewFeelingCell.delegate = self
            cell = addNewFeelingCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "feelingCell", for: indexPath)
            var feelings = currentMemory?.feelings?.allObjects as! [Feeling]
            cell.textLabel?.text = feelings[indexPath.row - 1].name
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let feelings = currentMemory?.feelings else {return 1}
        
        return feelings.count + 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let currentMemory = currentMemory,
                let feelings = currentMemory.feelings?.allObjects as? [Feeling] else { return }
            
            let feeling = feelings[indexPath.row - 1]
            
            ContextHelper.context.delete(feeling)
            saveCurrentContext()
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //========================================
    //MARK: - Add Feeling Delegate Methods
    //========================================
    
    func addFeeling(name: String) {
        guard let currentMemory = currentMemory else {return}
        let newFeeling = NSEntityDescription.insertNewObject(forEntityName: Feeling.entityName, into: ContextHelper.context) as! Feeling
        newFeeling.name = name
        newFeeling.memory = currentMemory
        
        saveCurrentContext()
        
        let newIndexPath = IndexPath(row: currentMemory.feelings!.count, section: 0)
        
        tableView.insertRows(at: [newIndexPath], with: .left)
    }
    
    //========================================
    //MARK: - Text Field Delegate Methods
    //========================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
            print(error)
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

