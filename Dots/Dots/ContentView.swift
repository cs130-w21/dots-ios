//
//  ContentView.swift
//  Dots
//
//  Created by Jack Zhao on 1/8/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {

    /// The binding data object.
    @Binding var mainData: DotsData

    /// The current phase of the scene.
    @Environment(\.scenePhase) private var scenePhase

    /// An authenticator that takes care of biometric authenticate policies.
    @State var authenticator: Authenticator = .init()

    /// Stores the value if user can be prompted to unlock with biometric automatically. The value is set to false after the first failed unlock trial.
    @State var attemptedAutoAuthenticate = true

    /// A save function to save the data.
    let saveAction: () -> Void
    
    private let isTest = CommandLine.arguments.contains("UITestMode")
    
    /// Content body view.
    var body: some View {

        ZStack {
            mainView(data: self.$mainData, authenticator: self.$authenticator, menuOption: self.$mainData.options
            )
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        saveAction()
                    }
                    else if phase == .background {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            if self.authenticator.enableAuthentication {
                                if phase == .background {
                                    self.authenticator.lock()
                                    self.attemptedAutoAuthenticate = !isTest // isTest ? false : true
                                }
                            }
                        }
                    }
                    else {
                        if !self.authenticator.isUnlocked() && self.authenticator.enableAuthentication && self.attemptedAutoAuthenticate{
                            self.authenticator.authenticate()
                            self.attemptedAutoAuthenticate = false
                        }
                    }
                }
            if !self.authenticator.isUnlocked() && self.authenticator.enableAuthentication  {
                
                BlurBackgroundView(style: .systemThinMaterial)
                VStack {
                    Image("icon-gray")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .padding()
                    Text("Dots - The Bill Splitter")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                        .padding(.bottom, 30)
                    Button(action: {
                        if isTest {
                            self.authenticator.unlock()
                        } else {
                            self.authenticator.authenticate()
                        }
                    }) {
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
        .onAppear() {
            if isTest {
                self.authenticator.enableAuthentication = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(mainData: .constant(DotsData.sample), saveAction: {})
    }
}
