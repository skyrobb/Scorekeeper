//
//  GamesTableViewController.swift
//  Scorekeeper
//
//  Created by Skyler Robbins on 11/18/24.
//

import UIKit

class GamesTableViewController: UITableViewController, GameTableViewControllerDelegate {
    
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindToGamesController(segue: UIStoryboardSegue) {
        if segue.identifier == "saveUnwind" {
            if let source = segue.source as? AddGameTableViewController {
                games.append(source.newGame!)
            }
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGame" {
            if let destination = segue.destination as? GameTableViewController {
                destination.game = games[tableView.indexPathForSelectedRow!.row]
                destination.delegate = self
            }
        }
    }
    
    func gameUpdated(game: Game) {
        print("game updated")
        var index = 0
        for testGame in games {
            if testGame.uuid == game.uuid {
                games[index] = game
                tableView.reloadData()
            }
        index += 1
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell

        let sortedPlayers = games[indexPath.row].players.sorted { $0.score > $1.score }
        
        cell.gameLabel.text = games[indexPath.row].name
        
        if games[indexPath.row].winCondition {
            cell.leaderLabel.text = "Leader: \(sortedPlayers.first!.name)"
        } else {
            cell.leaderLabel.text = "Leader: \(sortedPlayers.last!.name)"
        }

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
