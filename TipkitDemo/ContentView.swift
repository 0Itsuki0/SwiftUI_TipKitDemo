//
//  ContentView.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/07/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            NavigationLink(destination: {
                BasicTipView()
            }, label: {
                Text("Basic")
            })
            
            NavigationLink(destination: {
                ActionTipView()
            }, label: {
                Text("With Action")
            })
            
            NavigationLink(destination: {
                ControlledTipView()
            }, label: {
                Text("Controlled")
            })
            
            NavigationLink(destination: {
                CustomAppearanceTipView()
            }, label: {
                Text("UI Customization")
            })
        }
        .navigationTitle("Tip Kit Demo")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

