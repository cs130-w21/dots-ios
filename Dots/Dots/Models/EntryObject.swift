//
//  EntryObject.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation

struct EntryObject: Identifiable, Codable {
    let id: UUID
    var entryTitle: String?
    var participants: [Int]
    var amount: Double
    
    init(id: UUID = UUID(), entryTitle: String = "Untitled Entry", participants: [Int] = [], amount: Double = 0.0) {
        self.id = id
        self.entryTitle = entryTitle
        self.participants = participants
        self.amount = amount
    }
}
