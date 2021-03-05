//
//  DotsApp.swift
//  Dots
//
//  Created by Jack Zhao on 1/8/21.
//

import SwiftUI

/// Structure of the Dots app, observed master data object with user data and settings, and main body view.
@main
struct DotsApp: App {
    
    /// The observed master data object of the app, contains user data and user settings.
    @ObservedObject private var data = MainData()
    
    /// Main body view.
    var body: some Scene {
        WindowGroup {
            ContentView(mainData: $data.mainData) {
                data.save()
            }
            .onAppear {
                data.load()
            }
        }
    }
}
