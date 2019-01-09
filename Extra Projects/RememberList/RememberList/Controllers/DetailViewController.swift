//
//  ViewController.swift
//  RememberList
//
//  Created by Justin Snider on 1/8/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var sentFrom: String?
    var currentMemory: Memory?
    var feelings: [Feeling]?
    
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
            fetchFeelings()
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
            cell = tableView.dequeueReusableCell(withIdentifier: "addNewFeelingCell", for: indexPath) as! addNewFeelingTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "feelingCell", for: indexPath)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let feelings = feelings else {return 0}
        
        return feelings.count
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
    
    private func fetchFeelings() {
        let feelingsFetchRequest = NSFetchRequest<Feeling>(entityName: Feeling.entityName)
        
        do {
            self.feelings = try ContextHelper.context.fetch(feelingsFetchRequest)
        } catch {
            self.feelings = []
            print(error)
        }
    }
}

