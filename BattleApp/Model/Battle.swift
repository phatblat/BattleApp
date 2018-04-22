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
    var turnNumber = 1
    /// Each pair of turns is a round.
    var roundNumber = 1
}
