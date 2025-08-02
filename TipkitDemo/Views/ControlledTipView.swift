//
//  ControlledTipView.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//


import SwiftUI
import TipKit

struct ControlledTipView: View {
    
    @State private var pikachuLiked = false
    @State private var likedCount = 0

    @State private var isPresented: Bool = false
    
    private let inlineTip = InlineTip()
    private let parameterRuleTip = ParameterRuleTip()
    private let basicEventRuleTip = BasicEventRuleTip()
    private let eventRuleWithCustomTypeTip = EventRuleWithCustomTypeTip()
    private let optionTip = OptionTip()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // MARK: Control Display Timing: Rule Based
                VStack(alignment: .leading) {
                    Text("Display based on Parameter Rule")
                        .font(.headline)
                    
                    Text("Tip displayed if Liked")
                    
                    Button(action: {
                        pikachuLiked.toggle()
                    }, label: {
                        Text(pikachuLiked ? "Unlike Pikachu" : "Like Pikachu")
                    })
                    .onChange(of: pikachuLiked, {
                        // Parameter cannot trigger view updates
                        ParameterRuleTip.pikachuLiked = pikachuLiked
                    })
    
                    TipView(parameterRuleTip)
                }
                
                Divider()
    
                VStack(alignment: .leading) {
                    Text("Display based on Event Rule (Basic)")
                        .font(.headline)
                    
                    Text("Tip displayed if liked for more than 3 times")
                    
                    HStack {
                        Text(String("Current Liked Count: \(self.likedCount)"))
    
                        Button(action: {
                            self.likedCount += 1
                            // In addition, there is also
                            // - deleteDonations() to Deletes an event’s existing donations
                            Task {
                                await BasicEventRuleTip.pikachuLikedEvent.donate()
                            }
                            
                            // Asynchronous version
                            // BasicEventRuleTip.pikachuLikedEvent.sendDonation()
                        }, label: {
                            Text("Like Pikachu")
                        })
                    }
    
                    TipView(basicEventRuleTip)
                }
                
                Divider()
    
    
                VStack(alignment: .leading) {
                    Text("Display based on Event Rule (Custom Associate Value)")
                        .font(.headline)
                    
                    Text("Tip will be displayed if Pikachu is liked for more than 3 times within 1 minutes.")
                    
                    HStack {
                        Button(action: {
                            Task {
                                await EventRuleWithCustomTypeTip.pokemonLikedEvent.donate(.init(name: "Pikachu", liked: true))
                            }
                        }, label: {
                            Text("**Like Pikachu**")
                        })
                        Spacer()
                            .frame(width: 16)
                        Button(action: {
                            Task {
                                await EventRuleWithCustomTypeTip.pokemonLikedEvent.donate(.init(name: "Ditto", liked: true))
                            }
                        }, label: {
                            Text("Like Ditto")
                        })
                    }
    
                    TipView(eventRuleWithCustomTypeTip)
                }
                
                Divider()
    

                // MARK: Control Display Timing: Option based
                
                VStack(alignment: .leading) {
                    Text("Display based on Option")
                        .font(.headline)
                    
                    TipView(optionTip)
                }
                
                Divider()
                
    
                VStack(alignment: .leading) {
                    Text("Monitor/Control")
                        .font(.headline)
                    
                    Text("It is also possible to use the binding to temporarily hide or show a currently **displayable** tip")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    Toggle(isOn: $isPresented, label: {
                        Text("Is presented")
                    })
                                    
                    TipView(inlineTip, isPresented: $isPresented, arrowEdge: .none)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Reset Eligibility")
                        .font(.headline)
                    
                    Text("Use the `Reset` Button to make a previously invalidated tip re-eligible for display.")

                    Text("- Not working for popover tips. Maybe a beta bug")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    Button(action: {
                        Task {
                            await inlineTip.resetEligibility()
                        }
                    }, label: {
                        Text("Reset Tip Above")
                    })
                }
    
    
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .leading)

        }
        .navigationTitle("Controlled Tip")
        .background(.yellow.opacity(0.1))
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
            await self.parameterRuleTip.resetEligibility()
            await self.basicEventRuleTip.resetEligibility()
            await self.eventRuleWithCustomTypeTip.resetEligibility()
            await self.optionTip.resetEligibility()
        }
    }
}




#Preview {
    NavigationStack {
        ControlledTipView()
    }
}
