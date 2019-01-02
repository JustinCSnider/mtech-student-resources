//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by Justin Snider on 12/20/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var menuItems = [MenuItem]()
    var category: String?
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: MenuController.menuDataUpdatedNotification, object: nil)
        
        updateUI()
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        guard let category = category else { return }
        
        coder.encode(category, forKey: "category")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        
        category = coder.decodeObject(forKey: "category") as? String
        updateUI()
    }

    //========================================
    //MARK: - Table View Data Source
    //========================================

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //========================================
    //MARK: - Navigation
    //========================================
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "MenuDetailSegue" {
            let menuItemDetailViewController = segue.destination as! MenuItemDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuItemDetailViewController.menuItem = menuItems[index]
        }
    }

    //========================================
    //MARK: - Helper Methods
    //========================================
    
    @objc private func updateUI() {
        guard let category = category else { return }
        
        title = category.capitalized
        menuItems = MenuController.shared.items(forCategory: category) ?? []
        
        tableView.reloadData()
    }
    
    private func configure(_ cell: UITableViewCell, forItemAt indexpath: IndexPath) {
        let menuItem = menuItems[indexpath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        cell.imageView?.contentMode = .scaleAspectFit
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexpath {
                    return
                }
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
    }
}
