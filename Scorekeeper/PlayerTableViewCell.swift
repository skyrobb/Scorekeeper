//
//  PlayerTableViewCell.swift
//  Scorekeeper
//
//  Created by Skyler Robbins on 11/8/24.
//

import UIKit

protocol PlayerCellDelegate {
    func scoreUpdated(sender: PlayerTableViewCell)
}

class PlayerTableViewCell: UITableViewCell {
    
    var delegate: PlayerCellDelegate?
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var playerScoreStepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func scoreStepperValueChanged(_ sender: UIStepper) {
        playerScoreLabel.text = String(Int(sender.value))
        delegate?.scoreUpdated(sender: self)
    }
}
