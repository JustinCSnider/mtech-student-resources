//
//  RepTableViewCell.swift
//  RepresentativeCoreData
//
//  Created by Justin Snider on 1/14/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class RepTableViewCell: UITableViewCell {
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //========================================
    //MARK: - Helper Methods
    //========================================
    
    func updateCell(rep: Representative) {
        self.nameLabel.text = "Name: \(rep.name)"
        self.addressLabel.text = "Address: \(rep.address)"
        self.phoneNumberLabel.text = "Phone Number: \(rep.phoneNumber)"
    }

}
