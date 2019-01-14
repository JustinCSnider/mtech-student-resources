//
//  SearchRepsTableViewController.swift
//  RepresentativeCoreData
//
//  Created by Justin Snider on 1/14/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class SearchRepsTableViewController: UITableViewController, UISearchBarDelegate {
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var representatives: [Representative] = []
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //========================================
    //MARK: - Search Bar Delegate Methods
    //========================================
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        RepresentativeController.sharedController.searchForReps(zipcode: searchText) { (reps) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //========================================
    //MARK: - Table View Data/Delegate Methods
    //========================================

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return representatives.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath) as? RepTableViewCell else { return UITableViewCell() }

        let currentRep = representatives[indexPath.row]
        
        cell.updateCell(rep: currentRep)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentRep = representatives[indexPath.row]
        RepresentativeController.sharedController.saveRep(rep: currentRep)
        self.navigationController?.popViewController(animated: true)
    }
}
