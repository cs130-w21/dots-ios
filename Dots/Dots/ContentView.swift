//
//  ContentView.swift
//  Dots
//
//  Created by Jack Zhao on 1/8/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @Binding var mainData: DotsData
    
    @Environment(\.scenePhase) private var scenePhase
//    @State private var isUnlocked: Bool = false
    @State var authenicator: Authenticator = .init()
    @State var attemptedAutoAuthenticate = true
    let saveAction: () -> Void

    var body: some View {

        ZStack {
            mainView(data: self.$mainData, authenticator: self.$authenicator, menuOption: self.$mainData.options
            )
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        saveAction()
                    }
                    else if phase == .background {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            if self.authenicator.enableAuthentication {
                                if phase == .background {
                                    self.authenicator.lock()
                                    self.attemptedAutoAuthenticate = true
                                }
                            }
                        }
                    }
                    else {
                        if !self.authenicator.isUnlocked() && self.authenicator.enableAuthentication && self.attemptedAutoAuthenticate{
                            self.authenicator.authenticate()
                            self.attemptedAutoAuthenticate = false
                        }
                    }
                }
            if !self.authenicator.isUnlocked() && self.authenicator.enableAuthentication  {
                BlurBackgroundView(style: .systemThinMaterial)
                VStack {
                    Text("Locked")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                    Button(action: self.authenicator.authenticate) {
                        ZStack {
                            Text("Unlock")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .frame(width: 160, height: 50)
                                .background(BlurBackgroundView(style: .systemUltraThinMaterial)
                                                .clipShape(Capsule()))
                                
                        }
                    }
                }
                .frame(height: screen.height)
                .animation(.easeOut)
            }
        }
    }
    
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(mainData: .constant(DotsData.sample), saveAction: {})
    }
}
