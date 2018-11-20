//
//  GamesTableViewController.swift
//  ScoreKeeper
//
//  Created by Justin Snider on 11/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit
import CoreData

class GamesTableViewController: UITableViewController, ManagedObjectContextDependentType{
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var managedObjectContext: NSManagedObjectContext!
    
    var games: [Game] = []
    var delegate: currentGameDelegate?
    
    //========================================
    //MARK: - Life Cycle methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchGames()
        tableView.reloadData()
    }

    //========================================
    //MARK: - Table View Methods
    //========================================

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        
        let currentGame = games[indexPath.row]
        
        cell.textLabel?.text = currentGame.name
        cell.detailTextLabel?.text = currentGame.review
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(game: games[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            managedObjectContext.delete(games[indexPath.row])
            games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try self.managedObjectContext.save()
            } catch {
                print("Something went wrong \(error)")
                self.managedObjectContext.rollback()
            }
        }
    }

    //========================================
    //MARK: - Navigation
    //========================================
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destinationVC = segue.destination as? ScoresTableViewController {
            destinationVC.managedObjectContext = self.managedObjectContext
            delegate = destinationVC
        } else if let destinationVC = segue.destination as? AddGameViewController {
            destinationVC.managedObjectContext = self.managedObjectContext
        }
    }
    
    @IBAction func unwindToGameTableViewController(with segue: UIStoryboardSegue, sender: UIButton) {
        if let sourceVC = segue.source as? AddGameViewController {
            let dataService = DataService(managedObjectContext: self.managedObjectContext)
            
            let name = sourceVC.nameTextField.text ?? ""
            let review = sourceVC.reviewTextField.text ?? ""
            
            dataService.addGame(name: name, review: review)
            
            self.managedObjectContext = sourceVC.managedObjectContext
        }
        tableView.reloadData()
    }
    
    
    //========================================
    //MARK: - Core Data
    //========================================

    
    func fetchGames() {
        let gameFetchRequest = NSFetchRequest<Game>(entityName: Game.entityName)
        let nameSortDescriptor = NSSortDescriptor(key: #keyPath(Game.name), ascending: true)
        gameFetchRequest.sortDescriptors = [nameSortDescriptor]
        
        do {
            self.games = try self.managedObjectContext.fetch(gameFetchRequest)
        } catch {
            self.games = []
            print("Something went wrong \(error)")
        }
    }
    
    
}
