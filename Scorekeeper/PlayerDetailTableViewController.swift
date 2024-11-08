//
//  PlayerDetailTableViewController.swift
//  Scorekeeper
//
//  Created by Skyler Robbins on 11/8/24.
//

import UIKit

class PlayerDetailTableViewController: UITableViewController {

    var player: Player?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButtonEnabled()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveUnwind" {
            player = Player(name: nameTextField.text!, score: Int(scoreTextField.text!)!)
        }
    }
    
    func saveButtonEnabled(){
        if scoreTextField.text?.isEmpty == false && nameTextField.text?.isEmpty == false {
            if let score = Int(scoreTextField.text!) {
                saveButton.isEnabled = true
            } else {
                saveButton.isEnabled = false
            }
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func nameEditingDidEnd(_ sender: UITextField) {
        saveButtonEnabled()
    }
    
    @IBAction func scoreEditingDidEnd(_ sender: UITextField) {
        saveButtonEnabled()
    }
    
}
