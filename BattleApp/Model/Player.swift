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
        // Prevent health from going negative
        if currentHealth < 0 {
            currentHealth = 0
        }
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
    
    /// Reduces cooldown timers on all actions.
    ///
    /// - Returns: true if any actions were modified; false otherwise
    mutating func reduceCooldowns() -> Bool {
        var modified = false
        for (index, var action) in actions.enumerated() {
            if action.reduceCooldown() {
                actions[index] = action
                modified = true
            }
        }
        return modified
    }
}

extension Player {
    var formattedHealth: String {
        return "\(currentHealth) / \(totalHealth)"
    }

    /// returns a value between 0 and 1.
    var healthPercentage: Float {
        guard totalHealth > 0 else { return 0 }
        return Float(currentHealth) / Float(totalHealth)
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
