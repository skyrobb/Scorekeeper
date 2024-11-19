//
//  PlayerTableViewController.swift
//  Scorekeeper
//
//  Created by Skyler Robbins on 11/18/24.
//

import UIKit

class PlayerTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var player: Player?
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let player = player {
            nameTextField.text = player.name
            scoreTextField.text = String(player.score)
            print(indexPath!)
        }
        isSaveEnabled()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    @IBAction func nameTextFieldEditingChanged(_ sender: UITextField) {
        isSaveEnabled()
        if let name = nameTextField.text {
            player!.name = name
        }
    }
    
    @IBAction func scoreTextFieldEditingChanged(_ sender: UITextField) {
        isSaveEnabled()
        if let score = scoreTextField.text {
            if let score = Int(score) {
                player!.score = score
            }
        }
    }
    
    func isSaveEnabled() {
        if nameTextField != nil {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        if scoreTextField != nil {
            if let score = Int(scoreTextField.text!) {
                print(score)
                saveButton.isEnabled = true
            } else {
                saveButton.isEnabled = false
            }
        } else {
            saveButton.isEnabled = false
        }
    }

}
