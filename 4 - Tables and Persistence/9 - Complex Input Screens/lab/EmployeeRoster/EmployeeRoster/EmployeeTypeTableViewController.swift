//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Justin Snider on 11/9/18.
//

import UIKit

protocol EmployeeTypeDelegate {
    func didSelect(employeeType: EmployeeType)
}

class EmployeeTypeTableViewController: UITableViewController{
    
    
    var employeeType: EmployeeType?
    var delegate: EmployeeTypeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EmployeeType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeType", for: indexPath)
        
        let type = EmployeeType.all[indexPath.row]
        
        cell.textLabel?.text = type.description()
        
        if employeeType == type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeType = EmployeeType.all[indexPath.row]
        if let delegate = delegate, let employeeType = employeeType {
            delegate.didSelect(employeeType: employeeType)
        }
        tableView.reloadData()
    }

}
