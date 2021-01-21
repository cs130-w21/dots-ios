//
//  EntryObject.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation

struct EntryObject: Identifiable, Codable {
    let id: UUID
    var entryTitle: String
    var participants: [Int]
    var value: Double
    var amount: Int
    var withTax: Bool
    
    init(id: UUID = UUID(), entryTitle: String = "Untitled entry", participants: [Int] = [], value: Double = 0, amount: Int = 0, withTax: Bool = false) {
        self.id = id
        self.entryTitle = entryTitle
        self.participants = participants
        self.value = value
        self.amount = amount
        self.withTax = withTax
    }
}


extension EntryObject {
    static var sample: [EntryObject] {
        [
            EntryObject(entryTitle: "PlayStation 5", participants: [3, 5], value: 44, amount: 1),
            EntryObject(entryTitle: "Cyberpunk 2077", participants: [1], value: 142, amount: 6),
            EntryObject(entryTitle: "", participants: [0, 1, 9], value: 21, amount: 10, withTax: true)
        ]
    }
}
