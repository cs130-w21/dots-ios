//
//  Authenticator.swift
//  Dots
//
//  Created by Jack Zhao on 2/23/21.
//

//import Foundation
import LocalAuthentication

/// an authenticator for user to lock or unlock the Dots app with varies biometric types
class Authenticator {
    
    /// represent lock or unlock state with good or nogood cases, get to good if passed the authentication
    enum AuthState {
        case good
        case nogood
        
        func passed() -> Bool {
            return self == .good
        }
    }
    /// an boolean indicating whether the authentication is enabled or not
    var enableAuthentication: Bool
    private var context: LAContext
    private var state: AuthState
    
    /// a string warning for users
    let reason: String
    
    /// initialize the authentication
    /// - Parameter enableAuthentication: a boolean indicating whether the authentication is enabled or not
    init(enableAuthentication: Bool = false) {
        self.context = LAContext()
        self.state = .nogood
        self.enableAuthentication = enableAuthentication
        reason = "Protect your most important data. You just enabled it."
    }
    
    /// check the unlock status of the app
    /// - Returns: state shows the app is unlocked or not
    func isUnlocked() -> Bool {
        return self.state.passed()
    }
    
    /// set to nogood case
    func lock() {
        self.state = .nogood
    }
    
    /// set to good case
    func unlock() {
        self.state = .good
    }
    
    /// get biometric type
    /// - Returns: context of biometryType
    func biometricType() -> LABiometryType {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            return context.biometryType
        }
        return .none
    }
    
    /// authenticate the user by defined biometryType
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
