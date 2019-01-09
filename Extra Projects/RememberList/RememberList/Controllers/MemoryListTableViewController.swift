//
//  MemoryListTableViewController.swift
//  RememberList
//
//  Created by Justin Snider on 1/8/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit
import CoreData

class MemoryListTableViewController: UITableViewController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var managedObjectContext: ContextHelper!
    var memoryList = [Memory]()
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMemories()
    }

    //========================================
    //MARK: - Table View Data Source
    //========================================

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell", for: indexPath)
        
        let currentMemory = memoryList[indexPath.row]
        
        cell.textLabel?.text = currentMemory.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            ContextHelper.context.delete(memoryList[indexPath.row])
            saveCurrentContext()
            memoryList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //========================================
    //MARK: - Navigation Methods
    //========================================
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destination = segue.destination as? DetailViewController {
            if segue.identifier == "updateSegue" {
                destination.currentMemory = memoryList[tableView.indexPathForSelectedRow!.row]
            }
            destination.sentFrom = segue.identifier
        }
    }
    
    @IBAction func unwindToMemoryList(with segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? DetailViewController {
            fetchMemories()
            if let selectedIndexPath = tableView.indexPathForSelectedRow, let currentMemory = sourceVC.currentMemory {
                if sourceVC.CRUDButton.currentTitle == "Delete" {
                    tableView.deleteRows(at: [selectedIndexPath], with: .none)
                } else {
                    memoryList[selectedIndexPath.row] = currentMemory
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
            } else {
                
                let newIndexPath = IndexPath(row: memoryList.count - 1, section: 0)
                
                tableView.insertRows(at: [newIndexPath], with: .none)
            }
        }
    }
    
    //========================================
    //MARK: - Data Persistance Methods
    //========================================
    
    func fetchMemories() {
        let memoryFetchRequest = NSFetchRequest<Memory>(entityName: Memory.entityName)
        
        do {
            self.memoryList = try ContextHelper.context.fetch(memoryFetchRequest)
        } catch {
            self.memoryList = []
            print("Something went wrong \(error)")
        }
    }
    
    private func saveCurrentContext() {
        do {
            try ContextHelper.context.save()
        } catch {
            print("Failed to save")
            ContextHelper.context.rollback()
        }
    }
    
}
