//
//  PlayerTableViewCell.swift
//  Scorekeeper
//
//  Created by Skyler Robbins on 11/18/24.
//

import UIKit

protocol PlayerTableViewCellDelegate: AnyObject {
    func didUpdateScore(for player: Player, at index: Int)
}

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreStepper: UIStepper!
    
    weak var delegate: PlayerTableViewCellDelegate?
    var indexPath: Int?
    var game: Game?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func scoreStepperValueChanged(_ sender: UIStepper) {
        scoreLabel.text = String(Int(sender.value))
        delegate?.didUpdateScore(for: Player(name: nameLabel.text!, score: Int(sender.value)), at: indexPath!)
    }
}
