//
//  BattleViewController.swift
//  BattleApp
//
//  Created by Ben Chatelain on 4/21/18.
//  Copyright © 2018 Jack Chatelain. All rights reserved.
//

import UIKit

/// Displays current battle progress and player action buttons.
class BattleViewController: UIViewController {
    @IBOutlet var roundLabel: UILabel!

    @IBOutlet var player1Name: UILabel!
    @IBOutlet var player1Health: UILabel!
    @IBOutlet var player1HealthBar: UISlider!
    @IBOutlet var player1Action1: UIButton!
    @IBOutlet var player1Action2: UIButton!
    @IBOutlet var player1Action3: UIButton!
    @IBOutlet var player1Actions: [UIButton]!

    @IBOutlet var player2Name: UILabel!
    @IBOutlet var player2Health: UILabel!
    @IBOutlet var player2HealthBar: UISlider!
    @IBOutlet var player2Action1: UIButton!
    @IBOutlet var player2Action2: UIButton!
    @IBOutlet var player2Action3: UIButton!
    @IBOutlet var player2Actions: [UIButton]!

    @IBOutlet var versionLabel: UILabel!

    /// Model for the app.
    var battle: Battle?

    override func viewDidLoad() {
        super.viewDidLoad()
        wireUpButtonActions()
        updateUI()

        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] else {
            fatalError("Unable to access CFBundleShortVersionString in info.plist")
        }
        versionLabel.text = "Version \(version)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        debugPrint("\(String(describing: segue.identifier)) \(segue.destination)")
    }

    /// User-initiated end of battle.
    @IBAction func abortBattle(_ sender: Any) {
        let alert = UIAlertController(
            title: "End Battle?",
            message: "Are you sure you want to exit this battle? You will lose all progress made in this battle.",
            preferredStyle: .alert
        )
        let actionNo = UIAlertAction(title: "No", style: .cancel) { (_: UIAlertAction) in
            alert.dismiss(animated: true)
        }
        let actionYes = UIAlertAction(title: "Yes", style: .destructive) { [weak self] (_: UIAlertAction) in
            alert.dismiss(animated: true)
            self?.performSegue(withIdentifier: "unwindToSetup", sender: self)
        }
        alert.addAction(actionNo)
        alert.addAction(actionYes)
        present(alert, animated: true)
    }

    func endBattle(winner: Player) {
        let alert = UIAlertController(
            title: "Battle Over",
            message: "Congratulations! \(winner.name) has won this battle.",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "🎉 Hooray! 👑", style: .cancel) { (_: UIAlertAction) in
            alert.dismiss(animated:  true)
        }
        alert.addAction(action)

        present(alert, animated: true)
    }

    /// Convenience overload which unwraps the model.
    func updateUI() {
        guard let realBattle = battle else { return }
        updateUI(battle: realBattle)
    }

    /// Updates the UI with the current state of the model.
    func updateUI(battle: Battle) {
        roundLabel.text = "Round \(battle.roundNumber)"

        let player1 = battle.players[0]
        let player2 = battle.players[1]

        player1Name.text = player1.name
        player1Health.text = player1.formattedHealth
        player1HealthBar.value = player1.healthPercentage
        player1Action1.title = formatTitle("👊🏻", player1.actions[0])
        player1Action2.title = formatTitle("💥", player1.actions[1])
        player1Action3.title = formatTitle("💚", player1.actions[2])

        player2Name.text = player2.name
        player2Health.text = player2.formattedHealth
        player2HealthBar.value = player2.healthPercentage
        player2Action1.title = formatTitle("👊🏻", player2.actions[0])
        player2Action2.title = formatTitle("💥", player2.actions[1])
        player2Action3.title = formatTitle("💚", player2.actions[2])

        // Enforce turns by disabling buttons
        let enableActions: [UIButton]
        let disableActions: [UIButton]
        let activePlayer: Player
        if battle.turnNumber % 2 == 0 {
            // Player 1 goes on even numbered turns
            activePlayer = player1
            enableActions = player1Actions
            disableActions = player2Actions
        } else {
            // Player 2 goes on odd numbered turns
            activePlayer = player2
            enableActions = player2Actions
            disableActions = player1Actions
        }
        for (index, button) in enableActions.enumerated() {
            let action = activePlayer.actions[index]
            if action.isOnCooldown || action.healthAdjustment == 0 || !battle.active {
                // Don't enable actions still on cooldown or without damage
                button.isEnabled = false
            } else {
                button.isEnabled = true
            }
        }
        disableActions.forEach { button in
            button.isEnabled = false
        }
    }

    /// Formats a string for display.
    func formatTitle(_ emoji: String, _ action: Action) -> String {
        let actionName = action.name
        let healthAmount = action.healthAdjustment
        if action.isOnCooldown {
            let displayCooldown = action.currentCooldown
            return "\(emoji)\n\(actionName)\n(\(healthAmount))\ncooldown: \(displayCooldown)"
        }
        return "\(emoji)\n\(actionName)\n(\(healthAmount))"
    }

    /// Wires up actions to buttons using closures.
    func wireUpButtonActions() {
        player1Action1.add(for: .touchUpInside) { [weak self] in
            self?.performAction(playerNumber: .one, actionNumber: 1)
        }
        player1Action2.add(for: .touchUpInside) { [weak self] in
            self?.performAction(playerNumber: .one, actionNumber: 2)
        }
        player1Action3.add(for: .touchUpInside) { [weak self] in
            self?.performAction(playerNumber: .one, actionNumber: 3)
        }

        player2Action1.add(for: .touchUpInside) { [weak self] in
            self?.performAction(playerNumber: .two, actionNumber: 1)
        }
        player2Action2.add(for: .touchUpInside) { [weak self] in
            self?.performAction(playerNumber: .two, actionNumber: 2)
        }
        player2Action3.add(for: .touchUpInside) { [weak self] in
            self?.performAction(playerNumber: .two, actionNumber: 3)
        }

        // Center button text
        (player1Actions + player2Actions).forEach { button in
            button.titleLabel?.textAlignment = .center
        }
    }

    /// Invokes a player action.
    func performAction(playerNumber: PlayerNum, actionNumber: Int) {
        guard var realBattle = battle else { return }

        let player1 = realBattle.players[0]
        let player2 = realBattle.players[1]

        var player: Player
        var otherPlayer: Player

        switch playerNumber {
        case .one:
            player = player1
            otherPlayer = player2
        case .two:
            player = player2
            otherPlayer = player1
        }

        var action = player.actions[actionNumber - 1]
        if action.affectsSelf {
            player.increaseHealth(amount: action.healthAdjustment)
        } else {
            otherPlayer.reduceHealth(amount: action.healthAdjustment)
            if otherPlayer.currentHealth == 0 {
                endBattle(winner: player)
                realBattle.active = false
            }
        }

        // Update cooldown counter
        if action.cooldown > 0 {
            // FIXME: Adding one becuase nextTurn will reduce currentCooldown
            action.currentCooldown = action.cooldown + 1
            // Update the set of actions with the modified structs!
            player.actions[actionNumber - 1] = action
        }

        // Make sure to update the battle with the modified structs!

        switch playerNumber {
        case .one:
            realBattle.players = [player, otherPlayer]
        case .two:
            realBattle.players = [otherPlayer, player]
        }

        realBattle.nextTurn()

        battle = realBattle
        updateUI(battle: realBattle)
    }
}
