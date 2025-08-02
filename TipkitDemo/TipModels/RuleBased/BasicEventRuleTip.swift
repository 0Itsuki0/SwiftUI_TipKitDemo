//
//  EventRuleTip.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//

import TipKit

struct BasicEventRuleTip: Tip {
    // we can also specify `donationLimit` to control the Maximum number and maximum age of donations this event will persist and query.
    static let pikachuLikedEvent = Event(id: "pikachuLiked")

    var title: Text {
        Text("Thank you For liking Pikachu!")
    }
    
    var rules: [Rule] {
        // Define a rule based on the user-interaction state.
        #Rule(Self.pikachuLikedEvent) {
            // Tip will be displayed after the event is sent for more than 3 times.
            $0.donations.count >= 3
        }
    }
}
