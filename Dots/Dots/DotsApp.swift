//
//  DotsApp.swift
//  Dots
//
//  Created by Jack Zhao on 1/8/21.
//

import SwiftUI

@main
struct DotsApp: App {
<<<<<<< HEAD
    @ObservedObject private var data = MainData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(mainData: $data.mainData) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
=======
    var body: some Scene {
        WindowGroup {
            ContentView()
>>>>>>> 92b5e2a4e4aeea8d34b55e22bd5f68a887ba3e73
        }
    }
}
