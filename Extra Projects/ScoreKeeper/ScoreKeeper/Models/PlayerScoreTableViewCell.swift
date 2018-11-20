//
//  PlayerScoreTableViewCell.swift
//  ScoreKeeper
//
//  Created by Justin Snider on 11/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit
import CoreData

protocol TextFieldChanged {
    func didChange(string: String?, player: Player?)
}

class PlayerScoreTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var delegate: TextFieldChanged?
    
    var player: Player?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreStepper: UIStepper!
    @IBOutlet weak var scoreTextField: UITextField!
    
    //========================================
    //MARK: - Text Field Data Source
    //========================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scoreTextField.resignFirstResponder()
        self.delegate?.didChange(string: textField.text, player: player)
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        scoreTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
