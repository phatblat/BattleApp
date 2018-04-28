//
//  Battle.swift
//  BattleApp
//
//  Created by Ben Chatelain on 4/21/18.
//  Copyright © 2018 Jack Chatelain. All rights reserved.
//

import Foundation

struct Battle {
    var players: [Player]
    
    /// Indicates the player whose turn it is.
    var turnNumber: Int

    /// Each pair of turns is a round.
    var roundNumber: Int

    init(players: [Player], turnNumber: Int = 0, roundNumber: Int = 1) {
        self.players = players
        self.turnNumber = turnNumber
        self.roundNumber = roundNumber
    }

    mutating func nextTurn() {
        turnNumber = (turnNumber + 1) % 2
        if turnNumber == 0 {
            roundNumber += 1
        }
        print("round \(roundNumber), turn \(turnNumber)")
    }
}
