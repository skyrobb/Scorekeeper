//
//  AddGameTableViewController.swift
//  Scorekeeper
//
//  Created by Skyler Robbins on 11/18/24.
//

import UIKit

class AddGameTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var numberOfPlayersStepper: UIStepper!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var winConditionSegementedControl: UISegmentedControl!
    
    var newGame: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func numberOfPlayersStepperValueChanged(_ sender: UIStepper) {
        numberOfPlayersLabel.text = "Players: \(Int(sender.value))"
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        var winCondition = true
        let numberOfPlayers = Int(numberOfPlayersStepper.value)
        var players = [Player]()
        for player in 1...numberOfPlayers {
            players.append(Player(name: "Player \(player)", score: 0))
        }
        if winConditionSegementedControl.selectedSegmentIndex == 0 {
            winCondition = true
        } else if winConditionSegementedControl.selectedSegmentIndex == 1 {
            winCondition = false
        }
        newGame = Game(name: nameTextField.text ?? "New Game", players: players, winCondition: winCondition)
    }

}
