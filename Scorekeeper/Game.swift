//
//  Game.swift
//  Scorekeeper
//
//  Created by Skyler Robbins on 11/18/24.
//

import Foundation

struct Game {
    var name: String
    var players: [Player]
    var winCondition: Bool
    let uuid = UUID()
}
