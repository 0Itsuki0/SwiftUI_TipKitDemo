//
//  TipkitDemoApp.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/07/31.
//

import SwiftUI
import TipKit

@main
struct TipkitDemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
    
    init() {
        do {
            try setupTips()
        } catch {
            print("Error initializing tips: ", error)
        }
    }

    
    // Various way to override tip eligibility for testing.
    // Note: These must be called before `Tips.configure()`.
    private func setupTips() throws {
        // Show all defined tips in the app.
        // Tips.showAllTipsForTesting()

        // Show some tips, but not all.
        // Tips.showTipsForTesting([InlineTip.self])

        // Hide all tips defined in the app.
        // Tips.hideAllTipsForTesting()

        // Purge all TipKit-related data.
        #if DEBUG
        try Tips.resetDatastore()
        #endif

        // Configure and load all tips in the app.
        try Tips.configure([
            // Sets the CloudKit container used for syncing tips between multiple devices
            // required iCloud capability with cloudKitContainer setup, and Background Modes capability
            // .cloudKitContainer(.named("iCloud.com.itsuki.enjoy.TipkitDemo.container"))

            // set display frequency
            // other possible values: daily, weekly, and etc.
            .displayFrequency(.immediate),
            
            // Specify a custom location for tips datastore
            // By default URL.applicationSupportDirectory is used on macOS, iOS, watchOS, and visionOS.
            // this can either be set to a groupContainer (With App Groups Capability) or a custom URL
            // .datastoreLocation(.groupContainer(identifier: "groupIdentifier"))
            
        ])
    }
}
