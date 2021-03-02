//
//  Authenticator.swift
//  Dots
//
//  Created by Jack Zhao on 2/23/21.
//

//import Foundation
import LocalAuthentication

class Authenticator {
    
    enum AuthState {
        case good
        case nogood
        
        func passed() -> Bool {
            return self == .good
        }
    }
    var enableAuthentication: Bool
    private var context: LAContext
    private var state: AuthState
    let reason: String
    
    init(enableAuthentication: Bool = false) {
        self.context = LAContext()
        self.state = .nogood
        self.enableAuthentication = enableAuthentication
        reason = "Protect your most important data. You just enabled it."
    }
    
    func isUnlocked() -> Bool {
        return self.state.passed()
    }
    
    func lock() {
        self.state = .nogood
    }
    
    func unlock() {
        self.state = .good
    }
    
    func biometricType() -> LABiometryType {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            return context.biometryType
        }
        return .none
    }
    
    func authenticate() {
        var error: NSError?
        context = LAContext()
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "Add an extra layer of protection to your sensitive data."

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        // authenticated successfully
                        self.state = .good
                    } else {
                        // there was a problem
                        self.state = .nogood
                    }
                }
            }
        } else {
            // no biometrics
            self.state = .good
        }
    }
}
