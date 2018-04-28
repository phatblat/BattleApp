//
//  UIButton+Title.swift
//  BattleApp
//
//  Created by Ben Chatelain on 4/21/18.
//  Copyright © 2018 Jack Chatelain. All rights reserved.
//

import UIKit

extension UIButton {
    var title: String {
        set(value) {
            setTitle(value, for: UIControlState.normal)
            setTitle(value, for: UIControlState.selected)
        }
        get { return title(for: UIControlState.normal) ?? "" }
    }
}

/// https://stackoverflow.com/questions/25919472/adding-a-closure-as-target-to-a-uibutton
class ClosureSleeve {
    let closure: () -> Void

    init (_ closure: @escaping () -> Void) {
        self.closure = closure
    }

    @objc func invoke() {
        closure()
    }
}

extension UIControl {
    func add(for controlEvents: UIControlEvents, _ action: @escaping () -> Void) {
        let sleeve = ClosureSleeve(action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(
            self,
            String(ObjectIdentifier(self).hashValue) + String(controlEvents.rawValue),
            sleeve,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
    }
}
