//
//  AthleteFormViewController.swift
//  FavoriteAthlete
//
//  Created by Justin Snider on 10/24/18.
//

import UIKit

class AthleteFormViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var leagueTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!
    
    var athlete: Athlete?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        if let athlete = athlete {
            nameTextField.text = athlete.name
            ageTextField.text = String(athlete.age)
            leagueTextField.text = athlete.league
            teamTextField.text = athlete.team
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let name = nameTextField.text ?? "noName"
        let age = Int(ageTextField.text ?? "0")!
        let league = leagueTextField.text ?? "noLeague"
        let team = teamTextField.text ?? "noTeam"
        
        athlete = Athlete(name: name, age: age, league: league, team: team)
    }
    
}
