//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Justin Snider on 12/28/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    //========================================
    //MARK: - Outlets
    //========================================
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var menuItem: MenuItem?
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToOrderButton.layer.cornerRadius = 5.0
        updateUI()
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        guard let menuItem = menuItem else { return }
        
        coder.encode(menuItem.id, forKey: "menuItemId")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        let menuItemID = Int(coder.decodeInt32(forKey: "menuItemId"))
        menuItem = MenuController.shared.item(withID: menuItemID)
        updateUI()
    }
    
    //========================================
    //MARK: - IBActions
    //========================================
    
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        guard let menuItem = menuItem else { return }
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        MenuController.shared.order.menuItems.append(menuItem)
        MenuController.shared.saveOrder()
        MenuController.shared.saveItems()
    }
    
    //========================================
    //MARK: - Helper Methods
    //========================================
    
    private func updateUI() {
        guard let menuItem = menuItem else { return }
        
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        detailTextLabel.text = menuItem.detailText
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }

}
