//
//  ViewController.swift
//  APIProject
//
//  Created by Justin Snider on 12/12/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        return ModelController.currentItems.count
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch ModelController.currentType {
        case .randomUser:
            navigationItem.title = "Random Users"
        case .representative:
            navigationItem.title = "Representatives"
        case .nobelWinner:
            navigationItem.title = "Nobel Prize Winners"
        }
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
        case .nobelWinner:
            guard let currentItem = ModelController.currentItems[indexPath.row] as? NobelWinner else {return}
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.currentItem = ModelController.currentItems[tableView.indexPathForSelectedRow!.row]
        }
    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}
