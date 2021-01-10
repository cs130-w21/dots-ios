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
    
    init(id: UUID = UUID(), entryTitle: String? = nil, participants: [Int] = [], amount: Double = 0.0) {
        self.id = id
        self.entryTitle = entryTitle
        self.participants = participants
        self.amount = amount
    }
}


extension EntryObject {
    static var sample: [EntryObject] {
        [
            EntryObject(entryTitle: "PlayStation 5", participants: [3, 5], amount: 40),
            EntryObject(entryTitle: "Cyberpunk 2077", participants: [1], amount: 60),
            EntryObject(entryTitle: "", participants: [0, 1, 9], amount: 100.2)
        ]
    }
}
