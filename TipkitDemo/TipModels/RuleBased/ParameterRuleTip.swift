//
//  ControlledTip.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//


import TipKit

struct ParameterRuleTip: Tip {
    // Reset to default value the first time it is referenced.
    @Parameter(.transient)
    static var pikachuLiked: Bool = false

    var title: Text {
        Text("Thank you For liking Pikachu!")
    }
    
    // rules are AND together
    var rules: [Rule] {
        // Rules can also be based on Parameter defined in other structs, for example, views
        #Rule(ParameterRuleTip.$pikachuLiked) { liked in
            // Tip will only display when pikachuLiked is true.
            liked
        }
    }
}
