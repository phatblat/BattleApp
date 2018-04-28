//
//  Action.swift
//  BattleApp
//
//  Created by Ben Chatelain on 4/21/18.
//  Copyright © 2018 Jack Chatelain. All rights reserved.
//

import Foundation

struct Action {
    let name: String
    let healthAdjustment: Int
    let cooldown: Int
    var currentCooldown: Int
    let affectsSelf: Bool

    init(name: String, healthAdjustment: Int, cooldown: Int = 0, currentCooldown: Int = 0, affectsSelf: Bool = false) {
        self.name = name
        self.healthAdjustment = healthAdjustment
        self.cooldown = cooldown
        self.currentCooldown = currentCooldown
        self.affectsSelf = affectsSelf
    }

    /// Adjusts currentCooldown if necessary.
    mutating func reduceCooldown() -> Bool {
        guard cooldown > 0, currentCooldown > 0 else { return false }
        currentCooldown -= 1
        return true
    }
}

extension Action {
    /// Returns true when the action is on cooldown; false otherwise
    var isOnCooldown: Bool {
        return currentCooldown > 0
    }
}
