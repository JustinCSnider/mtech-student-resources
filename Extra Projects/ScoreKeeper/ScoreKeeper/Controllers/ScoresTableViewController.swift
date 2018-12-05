//
//  ScoresTableViewController.swift
//  ScoreKeeper
//
//  Created by Justin Snider on 11/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit
import CoreData

class ScoresTableViewController: UITableViewController, ManagedObjectContextDependentType, currentGameDelegate, TextFieldChanged {
    
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var managedObjectContext: NSManagedObjectContext!
    
    var players: [Player] = []
    var currentGame: Game?
    
    //========================================
    //MARK: - Life Cycle methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        players = []
        
        guard let currentPlayers = currentGame?.players else {return}
        
        for currentPlayer in currentPlayers {
            if let currentPlayer = currentPlayer as? Player {
                players.append(currentPlayer)
            }
        }
        tableView.reloadData()
    }
    
    //========================================
    //MARK: - Actions
    //========================================
    
    @objc func scoreStepperChanged(_ sender: UIStepper) {
        let cell = tableView.cellForRow(at: IndexPath(item: sender.tag, section: 0)) as! PlayerScoreTableViewCell
        
        players[sender.tag].score = Int32(sender.value)
        cell.scoreTextField.text = String(players[sender.tag].score)
        
        saveToCoreData()
    }
    
    func didSelect(game: Game) {
        currentGame = game
    }
    
    func didChange(string: String?, player: Player?) {
        if let string = string, let number = Int32(string) {
            
            player?.score = number
            
            saveToCoreData()
        }
        tableView.reloadData()
    }

    //========================================
    //MARK: - Table View Data Source
    //========================================

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerScoreCell", for: indexPath) as! PlayerScoreTableViewCell
        
        let currentPlayer = players[indexPath.row]
        
        cell.player = currentPlayer
        
        cell.scoreStepper.tag = indexPath.row
        cell.scoreStepper.addTarget(self, action: #selector(scoreStepperChanged(_:)), for: .valueChanged)
        cell.scoreStepper.value = Double(currentPlayer.score)
        
        cell.nameLabel.text = currentPlayer.name
        cell.scoreTextField.text = String(currentPlayer.score)
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            managedObjectContext.delete(players[indexPath.row])
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveToCoreData()
        }
    }
    
    //========================================
    //MARK: - Navigation
    //========================================
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destinationVC = segue.destination as? AddPlayerScoreViewController {
            destinationVC.managedObjectContext = self.managedObjectContext
        }
        
        saveToCoreData()
    }
    
    @IBAction func unwindToPlayerScoreTableViewController(with segue: UIStoryboardSegue, sender: UIButton) {
        if let sourceVC = segue.source as? AddPlayerScoreViewController, let currentGame = currentGame {
            let dataService = DataService(managedObjectContext: self.managedObjectContext)
            
            let name = sourceVC.nameTextField.text ?? ""
            let score = Int32(sourceVC.scoreLabel.text ?? "0") ?? 0
            
            
            dataService.addPlayer(name: name, score: score, game: currentGame)
            
            self.managedObjectContext = sourceVC.managedObjectContext
        }
    }
    
    //========================================
    //MARK: - Core Data
    //========================================
    
    
//    func fetchPlayers() {
//        let playersFetchRequest = NSFetchRequest<Player>(entityName: Player.entityName)
//
//        do {
//            self.players = try self.managedObjectContext.fetch(playersFetchRequest)
//        } catch {
//            self.players = []
//            print("Something went wrong \(error)")
//        }
//    }
    
    func saveToCoreData() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Something went wrong \(error)")
            managedObjectContext.rollback()
        }
    }
    
}


