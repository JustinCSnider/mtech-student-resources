//
//  ListTableViewController.swift
//  legitCoreData
//
//  Created by Justin Snider on 1/11/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TeamController.sharedController.getMyTeams()
        tableView.reloadData()
    }

    //========================================
    //MARK: - Table View Data/Delegate Methods
    //========================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TeamController.sharedController.teams.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        
        let currentTeam = TeamController.sharedController.teams[indexPath.row]

        cell.textLabel?.text = currentTeam.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            TeamController.sharedController.delete(team: TeamController.sharedController.teams[indexPath.row])
            TeamController.sharedController.teams.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //========================================
    //MARK: - Naviagtion Methods
    //========================================

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TeamDetailViewController {
            if segue.identifier == "toDetailView", let selectedIndexPath = tableView.indexPathForSelectedRow {
                destination.team = TeamController.sharedController.teams[selectedIndexPath.row]
            }
        }
    }
}
