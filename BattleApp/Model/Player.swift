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

    mutating func reduceHealth(amount: Int) {
        let previousValue = currentHealth
        currentHealth -= amount
        debugPrint("Player '\(name)' health reduced from \(previousValue) to \(currentHealth)")
    }
    
    mutating func increaseHealth(amount: Int) {
        let previousValue = currentHealth
        currentHealth += amount
        // Prevent health from going above total
        if currentHealth > totalHealth {
            currentHealth = totalHealth
        }
        debugPrint("Player '\(name)' health increased from \(previousValue) to \(currentHealth)")
    }
}

extension Player {
    var formattedHealth: String {
        return "\(currentHealth) / \(totalHealth)"
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}

enum PlayerNum {
    case one
    case two
}
