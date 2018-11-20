//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Justin Snider on 11/20/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var todos = [ToDo]()
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
    }

    //========================================
    //MARK: - Table View Data Source
    //========================================

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath)

        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //========================================
    //MARK: - Navigation
    //========================================

    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        
    }
}
