//
//  Authenticator.swift
//  Dots
//
//  Created by Jack Zhao on 2/23/21.
//

//import Foundation
import LocalAuthentication

/// An authenticator for user to lock or unlock the Dots app with varies biometric types.
class Authenticator {
    
    /// Represent lock or unlock state with good or nogood cases, get to good if passed the authentication.
    enum AuthState {
        case good
        case nogood
        
        func passed() -> Bool {
            return self == .good
        }
    }
    /// An boolean indicating whether the authentication is enabled or not.
    var enableAuthentication: Bool
    private var context: LAContext
    private var state: AuthState
    
    /// A string warning for users.
    let reason: String
    
    /// Initialize the authentication
    /// - Parameter enableAuthentication: a boolean indicating whether the authentication is enabled or not.
    init(enableAuthentication: Bool = false) {
        self.context = LAContext()
        self.state = .nogood
        self.enableAuthentication = enableAuthentication
        reason = "Protect your most important data. You just enabled it."
    }
    
    /// Check the unlock status of the app.
    /// - Returns: state shows the app is unlocked or not.
    func isUnlocked() -> Bool {
        return self.state.passed()
    }
    
    /// Set to nogood case of locked.
    func lock() {
        self.state = .nogood
    }
    
    /// Set to good case if unlocked.
    func unlock() {
        self.state = .good
    }
    
    /// Get biometric type.
    /// - Returns: context of biometryType.
    func biometricType() -> LABiometryType {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            return context.biometryType
        }
        return .none
    }
    
    /// Authenticate the user by defined biometryType.
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
