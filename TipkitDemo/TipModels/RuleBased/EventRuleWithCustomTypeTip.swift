//
//  EventRuleWithCustomTypeTip.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//

import TipKit

struct EventRuleWithCustomTypeTip: Tip {
    
    // nonisolated for Swift 6
    nonisolated
    struct PokemonLikeState: Codable, Sendable {
        var name: String
        var liked: Bool
    }

    static let pokemonLikedEvent: Tips.Event<PokemonLikeState> = Tips.Event(id: "pokemonLiked")


    var title: Text {
        Text("Thank you For liking Pikachu In Super High frequency!")
    }
    
    var rules: [Rule] {
        // Define a rule based on the user-interaction state.
        #Rule(Self.pokemonLikedEvent) {
            // Set the conditions for when the tip displays.
            // Tip will be displayed after the event is sent with Pikachu & Liked for more than 3 times within 1 minutes
            //
            // ** The filter expression within the rule is really buggy
            $0.donations.donatedWithin(.minute)
                .filter({ $0.liked == true }).filter({$0.name == "Pikachu" }).count >= 3

        }
        
    }
}
