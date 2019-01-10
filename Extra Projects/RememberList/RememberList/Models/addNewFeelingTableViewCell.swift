//
//  addNewFeelingTableViewCell.swift
//  RememberList
//
//  Created by Justin Snider on 1/9/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class addNewFeelingTableViewCell: UITableViewCell {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var delegate: addFeelingDelegate?
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var feelingTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //========================================
    //MARK: - IBActions
    //========================================
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        feelingTextField.resignFirstResponder()
        delegate?.addFeeling(name: feelingTextField.text ?? "")
        feelingTextField.text = ""
    }
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saveButton.layer.cornerRadius = 5
        saveButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
