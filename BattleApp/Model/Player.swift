//
//  Player.swift
//  BattleApp
//
//  Created by Ben Chatelain on 4/21/18.
//  Copyright © 2018 Jack Chatelain. All rights reserved.
//

import Foundation

struct Player {
    var name: String
    var totalHealth: Int
    var currentHealth: Int
    var actions: [Action]
}

extension Player {
    var formattedHealth: String {
        return "\(currentHealth) / \(totalHealth)"
    }
}
