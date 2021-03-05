//
//  menuOption.swift
//  Dots
//
//  Created by Jack Zhao on 2/19/21.
//

import Foundation

/// Contains all of the options of menu.
struct menuOption: Codable, Equatable {
    /// Boolean value indicates to group by initiator or not.
    var groupByInitiator: Bool = false
    /// Boolean value indicates to group by paid or not.
    var groupByPaid: Bool = false
    /// Boolean value indicates to hide paid bill or not.
    var hidePaid: Bool = false
    /// Enable faceID or not.
    var enableFaceId: Bool = false
}
