//
//  DotsApp.swift
//  Dots
//
//  Created by Jack Zhao on 1/8/21.
//

import SwiftUI

@main
struct DotsApp: App {
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
        }
    }
}
