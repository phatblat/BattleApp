//
//  BattleViewController.swift
//  BattleApp
//
//  Created by Ben Chatelain on 4/21/18.
//  Copyright © 2018 Jack Chatelain. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    @IBOutlet var player1Name: UILabel!
    @IBOutlet var player1Health: UILabel!
    @IBOutlet var player1HealthBar: UISlider!
    @IBOutlet var player1Action1: UIButton!
    @IBOutlet var player1Action2: UIButton!
    @IBOutlet var player1Action3: UIButton!

    @IBOutlet var player2Name: UILabel!
    @IBOutlet var player2Health: UILabel!
    @IBOutlet var player2HealthBar: UISlider!
    @IBOutlet var player2Action1: UIButton!
    @IBOutlet var player2Action2: UIButton!
    @IBOutlet var player2Action3: UIButton!

    var battle: Battle?

    override func viewDidLoad() {
        super.viewDidLoad()
        wireUpButtonActions()
        updateUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        debugPrint("\(String(describing: segue.identifier)) \(segue.destination)")
    }

    @IBAction func endBattle(_ sender: Any) {
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

    func updateUI() {
        guard let realBattle = battle else { return }
        updateUI(battle: realBattle)
    }

    func updateUI(battle: Battle) {
        var player1 = battle.players[0]
        var player2 = battle.players[1]

        player1Name.text = player1.name
        player1Health.text = player1.formattedHealth
        player1HealthBar.value = player1.healthPercentage
        player1Action1.setTitle("👊🏻 \(player1.actions[0].name) (\(player1.actions[0].healthAdjustment))")
        player1Action2.setTitle("💥 \(player1.actions[1].name) (\(player1.actions[1].healthAdjustment))")
        player1Action3.setTitle("💚 \(player1.actions[2].name) (\(player1.actions[2].healthAdjustment))")

        player2Name.text = player2.name
        player2Health.text = player2.formattedHealth
        player2HealthBar.value = player2.healthPercentage
        player2Action1.setTitle("👊🏻 \(player2.actions[0].name) (\(player2.actions[0].healthAdjustment))")
        player2Action2.setTitle("💥 \(player2.actions[1].name) (\(player2.actions[1].healthAdjustment))")
        player2Action3.setTitle("💚 \(player2.actions[2].name) (\(player2.actions[2].healthAdjustment))")
    }

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
    }

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

        let action = player.actions[actionNumber - 1]
        if action.affectsSelf {
            player.increaseHealth(amount: action.healthAdjustment)
        } else {
            otherPlayer.reduceHealth(amount: action.healthAdjustment)
        }

        // Make sure to update the battle with the modified structs!

        switch playerNumber {
        case .one:
            realBattle.players = [player, otherPlayer]
        case .two:
            realBattle.players = [otherPlayer, player]
        }

        battle = realBattle
        updateUI()
    }
}
