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
    
    func fetchMatchingItems() {
        
        ModelController.currentItems = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        
        if !searchTerm.isEmpty {
            let query = [
                "term" : searchTerm,
                "media" : mediaType,
                "limit" : "10",
                "lang" : "en_us"
            ]
            
            
            storeItemController.fetchItems(matching: query) { (results) in
                DispatchQueue.main.async {
                    if let results = results {
                        self.items = results
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
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

