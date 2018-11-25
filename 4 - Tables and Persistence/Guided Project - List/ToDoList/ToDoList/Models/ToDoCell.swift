//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Justin Snider on 11/25/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

@objc protocol ToDoCellDelegate: class {
    func checkMarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var delegate: ToDoCellDelegate?
    
    //========================================
    //MARK: - Outlets
    //========================================
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    //========================================
    //MARK: - Actions
    //========================================
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkMarkTapped(sender: self)
    }
    
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

}
