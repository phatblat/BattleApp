//
//  UIButton+Title.swift
//  BattleApp
//
//  Created by Ben Chatelain on 4/21/18.
//  Copyright © 2018 Jack Chatelain. All rights reserved.
//

import UIKit

extension UIButton {
    func setTitle(_ title: String) {
        setTitle(title, for: UIControlState.normal)
        setTitle(title, for: UIControlState.selected)
    }
}
