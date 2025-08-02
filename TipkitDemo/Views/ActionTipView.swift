//
//  ActionTipView.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//

import SwiftUI
import TipKit

struct ActionTipView: View {
    
    @Environment(\.openURL) var openURL

    private let actionTip = ActionTip()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Tip with action to open an URL in Safari")
                .font(.headline)

            TipView(actionTip, action: { action in
                if action.id == "more" {
                    guard let url = URL(string: "https://bulbapedia.bulbagarden.net/wiki/Pikachu_(Pokémon)") else {
                        return
                    }
                    
                    openURL(url)
                }
            })
        }
        .padding(.vertical)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.yellow.opacity(0.1))
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Tip With Action")
        .onAppear {
            // just in case those are invalidated
            self.resetEligibility()
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    self.resetEligibility()
                }, label: {
                    Text("Reset")
                })

            })
        })
    }
    
    private func resetEligibility() {
        Task {
            await self.actionTip.resetEligibility()
        }
    }
}


//#Preview {
//    NavigationStack {
//        ActionTipView()
//    }
//}
