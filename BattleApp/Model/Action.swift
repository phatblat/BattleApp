//
//  Action.swift
//  BattleApp
//
//  Created by Ben Chatelain on 4/21/18.
//  Copyright © 2018 Jack Chatelain. All rights reserved.
//

import Foundation

struct Action {
    var name: String
    var healthAdjustment: Int
    var cooldown = 0
    var affectsSelf = false
}
