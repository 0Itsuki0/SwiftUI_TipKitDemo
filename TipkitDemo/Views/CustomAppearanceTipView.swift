//
//  Custom.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//

import SwiftUI
import TipKit


struct CustomAppearanceTipView: View {
    private let inlineTip = InlineTip()
    private let popoverTip = PopoverTip()
        
    var body: some View {
    
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Edges based Tip arrow")
                        .font(.headline)
                                    
                    Text("bottom")
                    Text("- Available values: top, leading, trailing, none")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    TipView(inlineTip, arrowEdge: .bottom)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Anchor View Based Tip Arrow")
                        .font(.headline)
                    
                    Text("Anchor View")
                        .padding(.horizontal)
                        .border(.red)
                        .tipAnchor(0)
                                    
                    TipView(inlineTip, anchorID: 0)
                }
                
                Divider()

                
                VStack(alignment: .leading) {
                    Text("Background Style")
                        .font(.headline)
                    
                    Text("- Currently only applies to inline tips, not popover tips")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    TipView(inlineTip)
                        .tipBackground(LinearGradient(colors: [.red.opacity(0.2), .blue.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                

                Divider()

                VStack(alignment: .leading) {
                    Text("Corner Radius")
                        .font(.headline)

                    TipView(inlineTip)
                        .tipCornerRadius(0)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Image Size & style")
                        .font(.headline)

                    TipView(inlineTip)
                        .tipImageSize(.init(width: 24, height: 24))
                        .tipImageStyle(.pink, .blue, .yellow)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Custom View Style")
                        .font(.headline)

                    TipView(inlineTip)
                        .tipViewStyle(InlineTipViewStyle())
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Enable Background Interaction?")
                        .font(.headline)
                    
                    Text("- What this modifier is NOT penetrating hit test to content behind, but allow interaction, for example, scrolling the view without dismissing the popover tip first.")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    Text("⭐Pikachu⭐")
                        .contentShape(Rectangle())
                        .popoverTip(popoverTip)
                        .tipBackgroundInteraction(.enabled)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        
        }
        .background(.yellow.opacity(0.1))
        .navigationTitle("Custom Appearance")
        .navigationBarTitleDisplayMode(.large)
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

private struct InlineTipViewStyle: TipViewStyle {
    func makeBody(configuration: TipViewStyle.Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("TIP").font(.system(.headline).smallCaps())
                Spacer()
                
                // to show a close button, uncomment the following.
//                Button(action: { configuration.tip.invalidate(reason: .tipClosed) }) {
//                    Image(systemName: "xmark").scaledToFit()
//                }
            }

            Divider().frame(height: 1.0)

            HStack(alignment: .top) {
                configuration.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48.0, height: 48.0)


                VStack(alignment: .leading, spacing: 8.0) {
                    configuration.title?.font(.headline)
                    configuration.message?.font(.subheadline)


                    ForEach(configuration.actions) { action in
                        Button(action: action.handler) {
                            action.label().foregroundStyle(.blue)
                        }
                    }
                }
            }
            .padding(.vertical, 8)
        }
        .padding()
    
    }
}

//
//#Preview {
//    NavigationStack {
//        CustomAppearanceTipView()
//    }
//}
