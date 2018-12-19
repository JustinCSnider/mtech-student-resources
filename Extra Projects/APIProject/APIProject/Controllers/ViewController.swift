//
//  ViewController.swift
//  APIProject
//
//  Created by Justin Snider on 12/12/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, newTypeDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var networkController = NetworkController()
    
    func fetchMatchingItems() {
        
        ModelController.currentItems = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        
        if !searchTerm.isEmpty {
            
            
            networkController.fetchItems(searchTerm) { (results) in
                DispatchQueue.main.async {
                    if let results = results {
                        ModelController.currentItems = results
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ModelController.currentType == .representative || ModelController.currentType == .randomUser {
            return ModelController.currentItems.count
        } else {
            guard let nobelWinner = ModelController.currentItems[section] as? NobelWinner else {return 1}
            
            return nobelWinner.laureates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch ModelController.currentType {
        case .randomUser:
            cell = tableView.dequeueReusableCell(withIdentifier: "randomUser", for: indexPath) as! RandomUserTableViewCell
        case .representative:
            cell = tableView.dequeueReusableCell(withIdentifier: "representative", for: indexPath)
        case .nobelWinner:
            cell = tableView.dequeueReusableCell(withIdentifier: "nobelWinner", for: indexPath)
        }
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch ModelController.currentType {
        case .randomUser:
            return 1
        case .representative:
            return 1
        case .nobelWinner:
            return ModelController.currentItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch ModelController.currentType {
        case .nobelWinner:
            guard let nobelWinners = ModelController.currentItems as? [NobelWinner] else {return nil}
            return nobelWinners[section].category
        case .representative:
            return ""
        case .randomUser:
            return ""
        }
    }
    
    func newTypeSet(with title: String, placeHolderText: String) {
        navigationItem.title = title
        searchBar.text = ""
        searchBar.placeholder = placeHolderText
        ModelController.currentItems = []
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        switch ModelController.currentType {
        case .randomUser:
            if let cell = cell as? RandomUserTableViewCell {
                guard let currentItem = ModelController.currentItems[indexPath.row] as? RandomUser else {return}
                
                cell.usernameLabel?.text = currentItem.userName
                
                URLSession.shared.dataTask(with: currentItem.thumbNailURL) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.thumbNail?.image = image
                        }
                    }
                }.resume()
            }
        case .representative:
            guard let currentItem = ModelController.currentItems[indexPath.row] as? Representative else {return}
            
            cell.textLabel?.text = "Name: " + currentItem.name
            cell.detailTextLabel?.text = "District: " + currentItem.district
        case .nobelWinner:
            guard let currentItem = ModelController.currentItems[indexPath.section] as? NobelWinner else {return}
            
            cell.textLabel?.text = "Name: " + currentItem.laureates[indexPath.row].firstName + " " + currentItem.laureates[indexPath.row].surName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            if ModelController.currentType == .randomUser || ModelController.currentType == .representative {
                destination.currentItem = ModelController.currentItems[tableView.indexPathForSelectedRow!.row]
            } else {
                destination.currentItem = ModelController.currentItems[tableView.indexPathForSelectedRow!.section]
                guard let currentItem = ModelController.currentItems[tableView.indexPathForSelectedRow!.section] as? NobelWinner else {return}
                destination.selectedItem = currentItem.laureates[tableView.indexPathForSelectedRow!.row]
            }
        } else if let destination = segue.destination as? FilterTableViewController {
            destination.delegate = self
        }
    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}
