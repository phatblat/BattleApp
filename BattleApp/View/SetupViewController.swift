//
//  SetupViewController.swift
//  BattleApp
//
//  Created by Ben Chatelain on 4/21/18.
//  Copyright © 2018 Jack Chatelain. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    @IBOutlet var player1Name: UITextField!
    @IBOutlet var player1Health: UITextField!
    @IBOutlet var player1Action1Name: UITextField!
    @IBOutlet var player1Action1Damage: UITextField!
    @IBOutlet var player1Action1Cooldown: UITextField!
    @IBOutlet var player1Action2Name: UITextField!
    @IBOutlet var player1Action2Damage: UITextField!
    @IBOutlet var player1Action2Cooldown: UITextField!
    @IBOutlet var player1Action3Name: UITextField!
    @IBOutlet var player1Action3Damage: UITextField!
    @IBOutlet var player1Action3Cooldown: UITextField!

    @IBOutlet var player2Name: UITextField!
    @IBOutlet var player2Health: UITextField!
    @IBOutlet var player2Action1Name: UITextField!
    @IBOutlet var player2Action1Damage: UITextField!
    @IBOutlet var player2Action1Cooldown: UITextField!
    @IBOutlet var player2Action2Name: UITextField!
    @IBOutlet var player2Action2Damage: UITextField!
    @IBOutlet var player2Action2Cooldown: UITextField!
    @IBOutlet var player2Action3Name: UITextField!
    @IBOutlet var player2Action3Damage: UITextField!
    @IBOutlet var player2Action3Cooldown: UITextField!

    @IBOutlet var battleButton: UIButton!
    var battle: Battle?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if id != "battle" { return }

        guard let realBattle = battle,
            let battleVC = segue.destination as? BattleViewController
            else { return }

        battleVC.battle = realBattle
    }

    @IBAction func validateInputFromNavbar(_ sender: UIBarButtonItem) {
        validateInput(sender)
    }

    @IBAction func validateInput(_ sender: Any) {
        let player1opt = createPlayer1()
        let player2opt = createPlayer2()

        guard let player1 = player1opt, let player2 = player2opt else { return }

        battle = Battle(players: [player1, player2])
        performSegue(withIdentifier: "battle", sender: self)
    }

    @IBAction func unwindToSetup(segue: UIStoryboardSegue) {
        debugPrint("\(String(describing: segue.identifier)) \(segue.destination)")
    }

    func createPlayer1() -> Player? {
        guard let health = player1Health.text, let totalHealth = Int(health) else {
            error(message: "Player 1 health value is not valid.")
            player1Health.becomeFirstResponder()
            return nil
        }
        guard let damage1Text = player1Action1Damage.text, let damage1 = Int(damage1Text) else {
            error(message: "Player 1 action 1 damage value is not valid.")
            player1Action1Damage.becomeFirstResponder()
            return nil
        }
        guard let cooldown1Text = player1Action1Cooldown.text, let cooldown1 = Int(cooldown1Text) else {
            error(message: "Player 1 action 1 cooldown value is not valid.")
            player1Action1Cooldown.becomeFirstResponder()
            return nil
        }
        guard let damage2Text = player1Action2Damage.text, let damage2 = Int(damage2Text) else {
            error(message: "Player 1 action 2 damage value is not valid.")
            player1Action2Damage.becomeFirstResponder()
            return nil
        }
        guard let cooldown2Text = player1Action2Cooldown.text, let cooldown2 = Int(cooldown2Text) else {
            error(message: "Player 1 action 2 cooldown value is not valid.")
            player1Action2Cooldown.becomeFirstResponder()
            return nil
        }
        guard let damage3Text = player1Action3Damage.text, let damage3 = Int(damage3Text) else {
            error(message: "Player 1 action 3 damage value is not valid.")
            player1Action3Damage.becomeFirstResponder()
            return nil
        }
        guard let cooldown3Text = player1Action3Cooldown.text, let cooldown3 = Int(cooldown3Text) else {
            error(message: "Player 1 action 3 cooldown value is not valid.")
            player1Action3Cooldown.becomeFirstResponder()
            return nil
        }

        let action1 = Action(
            name: player1Action1Name.text!,
            healthAdjustment: damage1,
            cooldown: cooldown1
        )
        let action2 = Action(
            name: player1Action2Name.text!,
            healthAdjustment: damage2,
            cooldown: cooldown2
        )
        let action3 = Action(
            name: player1Action3Name.text!,
            healthAdjustment: damage3,
            cooldown: cooldown3,
            affectsSelf: true
        )
        let player = Player(
            name: player1Name.text!,
            totalHealth: totalHealth,
            currentHealth: totalHealth,
            actions: [action1, action2, action3]
        )

        return player
    }

    func createPlayer2() -> Player? {
        guard let health = player2Health.text, let totalHealth = Int(health) else {
            error(message: "Player 2 health value is not valid.")
            player2Health.becomeFirstResponder()
            return nil
        }
        guard let damage1Text = player2Action1Damage.text, let damage1 = Int(damage1Text) else {
            error(message: "Player 2 action 1 damage value is not valid.")
            player2Action1Damage.becomeFirstResponder()
            return nil
        }
        guard let cooldown1Text = player2Action1Cooldown.text, let cooldown1 = Int(cooldown1Text) else {
            error(message: "Player 2 action 1 cooldown value is not valid.")
            player2Action1Cooldown.becomeFirstResponder()
            return nil
        }
        guard let damage2Text = player2Action2Damage.text, let damage2 = Int(damage2Text) else {
            error(message: "Player 2 action 2 damage value is not valid.")
            player2Action2Damage.becomeFirstResponder()
            return nil
        }
        guard let cooldown2Text = player2Action2Cooldown.text, let cooldown2 = Int(cooldown2Text) else {
            error(message: "Player 2 action 2 cooldown value is not valid.")
            player2Action2Cooldown.becomeFirstResponder()
            return nil
        }
        guard let damage3Text = player2Action3Damage.text, let damage3 = Int(damage3Text) else {
            error(message: "Player 2 action 3 damage value is not valid.")
            player2Action1Damage.becomeFirstResponder()
            return nil
        }
        guard let cooldown3Text = player2Action3Cooldown.text, let cooldown3 = Int(cooldown3Text) else {
            error(message: "Player 2 action 3 cooldown value is not valid.")
            player2Action3Cooldown.becomeFirstResponder()
            return nil
        }

        let action1 = Action(
            name: player2Action1Name.text!,
            healthAdjustment: damage1,
            cooldown: cooldown1
        )
        let action2 = Action(
            name: player2Action2Name.text!,
            healthAdjustment: damage2,
            cooldown: cooldown2
        )
        let action3 = Action(
            name: player2Action3Name.text!,
            healthAdjustment: damage3,
            cooldown: cooldown3,
            affectsSelf: true
        )
        let player = Player(
            name: player2Name.text!,
            totalHealth: totalHealth,
            currentHealth: totalHealth,
            actions: [action1, action2, action3]
        )

        return player
    }

    /// Presents an alert with a message and single button.
    func error(message: String) {
        let alert = UIAlertController(
            title: "Input Error",
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
