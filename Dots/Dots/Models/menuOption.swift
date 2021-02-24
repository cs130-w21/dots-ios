//
//  menuOption.swift
//  Dots
//
//  Created by Jack Zhao on 2/19/21.
//

import Foundation

struct menuOption: Codable, Equatable {
    var groupByInitiator: Bool = false
    var groupByPaid: Bool = false
    var hidePaid: Bool = false
    var enableFaceId: Bool = false
}
