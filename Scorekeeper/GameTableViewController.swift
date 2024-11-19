//
//  GameTableViewController.swift
//  Scorekeeper
//
//  Created by Skyler Robbins on 11/18/24.
//

import UIKit

protocol GameTableViewControllerDelegate: AnyObject {
    func gameUpdated(game: Game)
}

class GameTableViewController: UITableViewController, PlayerTableViewCellDelegate {
    
    var game: Game?
    weak var delegate: GameTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = game!.name
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return game!.players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell

        let currentPlayer  = game!.players[indexPath.row]
        
        cell.indexPath = indexPath.row
        cell.game = game!
        cell.nameLabel.text = currentPlayer.name
        cell.scoreLabel.text = String(currentPlayer.score)
        cell.scoreStepper.value = Double(currentPlayer.score)
        cell.delegate = self

        return cell
    }
    
    func didUpdateScore(for player: Player, at index: Int) {
        game!.players[index] = player
        tableView.reloadData()
        delegate?.gameUpdated(game: game!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPlayer" {
            if let navigationController = segue.destination as? UINavigationController {
                if let rootViewController = navigationController.topViewController as? PlayerTableViewController {
                    rootViewController.player = Player(name: "New Player", score: 0)
                    rootViewController.indexPath = game!.players.count
                }
            }
        } else if segue.identifier == "editPlayer" {
            if let navigationController = segue.destination as? UINavigationController {
                if let rootViewController = navigationController.topViewController as? PlayerTableViewController {
                    let indexPath = tableView.indexPathForSelectedRow!.row
                    rootViewController.player = game!.players[indexPath]
                    rootViewController.indexPath = indexPath
                }
            }
        }
    }
    
    @IBAction func unwindToGameTableViewController(_ segue: UIStoryboardSegue) {
        if segue.identifier == "savePlayerUnwind" {
            if let source = segue.source as? PlayerTableViewController {
                if let indexPath = source.indexPath {
                    if let player = source.player {
                        if game!.players.count <= indexPath {
                            game!.players.append(player)
                        } else {
                            game!.players[indexPath] = player
                        }
                        tableView.reloadData()
                    }
                }
            }
        } else if segue.identifier == "deletePlayerUnwind" {
            if let source = segue.source as? PlayerTableViewController {
                if let indexPath = source.indexPath {
                    if game!.players.count > indexPath {
                        game!.players.remove(at: indexPath)
                        tableView.reloadData()
                    }
                }
            }
        }
        delegate?.gameUpdated(game: game!)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
