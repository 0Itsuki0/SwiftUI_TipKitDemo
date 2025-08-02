//
//  BasicTipView.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//

import SwiftUI
import TipKit

struct BasicTipView: View {

    private let inlineTip = InlineTip()
    private let popoverTip = PopoverTip()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(alignment: .leading) {
                Text("Inline Tip")
                    .font(.headline)

                Button(action: {
                    inlineTip.invalidate(reason: .actionPerformed)
                }, label: {
                    Text("invalidate")
                })
                TipView(inlineTip, arrowEdge: nil)

            }

            Divider()
            
            VStack(alignment: .leading) {
                Text("Popover Tip")
                    .font(.headline)
                        
                Text("⭐Pikachu⭐")
                    .font(.headline)
                    .popoverTip(popoverTip)
                    .tipBackgroundInteraction(.enabled)

            }

        }
        .padding(.vertical)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.yellow.opacity(0.1))
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Basic Tip")
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
            await self.inlineTip.resetEligibility()
            await self.popoverTip.resetEligibility()
        }
    }
}

//
//#Preview {
//    NavigationStack {
//        BasicTipView()
//    }
//}
