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
    @IBOutlet var player1Action1: UIButton!
    @IBOutlet var player1Action2: UIButton!
    @IBOutlet var player1Action3: UIButton!

    @IBOutlet var player2Name: UILabel!
    @IBOutlet var player2Health: UILabel!
    @IBOutlet var player2Action1: UIButton!
    @IBOutlet var player2Action2: UIButton!
    @IBOutlet var player2Action3: UIButton!

    var battle: Battle?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let realBattle = battle else { return }
        updateUI(battle: realBattle)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        debugPrint("\(segue.identifier) \(segue.destination)")
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
    
    func updateUI(battle: Battle) {
        let player1 = battle.players[0]
        player1Name.text = player1.name
        player1Health.text = player1.formattedHealth
        player1Action1.setTitle(player1.actions[0].name)
        player1Action2.setTitle(player1.actions[1].name)
        player1Action3.setTitle(player1.actions[2].name)

        let player2 = battle.players[1]
        player2Name.text = player2.name
        player2Health.text = player2.formattedHealth
        player2Action1.setTitle(player2.actions[0].name)
        player2Action2.setTitle(player2.actions[1].name)
        player2Action3.setTitle(player2.actions[2].name)
    }
}
