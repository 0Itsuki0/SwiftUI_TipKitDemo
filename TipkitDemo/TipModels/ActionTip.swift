//
//  ActionTip.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//

import TipKit

struct ActionTip: Tip {
    var title: Text {
        Text("What is Pikachu?")
    }

    var message: Text? {
        Text("Find Out more about Pikachu!")
    }

    var actions: [Action] {
        // we can also pass in the `perform` parameter here to specify the action to perform when user interact with the button
        Action(id: "more", title: "More About Pikachu!")
    }
}
