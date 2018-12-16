//
//  RandomUserTableViewCell.swift
//  APIProject
//
//  Created by Justin Snider on 12/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class RandomUserTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var thumbNail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
