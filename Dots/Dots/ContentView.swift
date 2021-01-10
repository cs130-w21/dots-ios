//
//  ContentView.swift
//  Dots
//
//  Created by Jack Zhao on 1/8/21.
//

import SwiftUI

struct ContentView: View {
<<<<<<< HEAD
    @Binding var mainData: DotsData
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onChange(of: scenePhase) { phase in
                if phase == .inactive {
                    saveAction()
                }
            }
    }
    

=======
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
>>>>>>> 92b5e2a4e4aeea8d34b55e22bd5f68a887ba3e73
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
<<<<<<< HEAD
        ContentView(mainData: .constant(DotsData.sample), saveAction: {})
=======
        ContentView()
>>>>>>> 92b5e2a4e4aeea8d34b55e22bd5f68a887ba3e73
    }
}
