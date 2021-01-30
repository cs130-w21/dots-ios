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
    
    init(id: UUID = UUID(), entryTitle: String = "", participants: [Int] = [], value: Double = 0, amount: Int = 1, withTax: Bool = false) {
        self.id = id
        self.entryTitle = entryTitle
        self.participants = participants
        self.value = value
        self.amount = amount
        self.withTax = withTax
    }
    
    // MARK: Accessors
    
    // TODO: get entry total: DON'T FORGET TAX
    func getEntryTotal() -> Double {
        return 0.0
    }
    
    // TODO: get participants
    func getParticipants() -> [Int] {
        return []
    }
    
    // MARK: Mutators
    
    // TODO: set entry title
    mutating func setEntryTitle(title: String) {
        
    }
    
    // TODO: set entry value
    mutating func setEntryValue(value: Double) {
        
    }
    
    // TODO: set entry amount (item number)
    mutating func setEntryAmount(amount: Int) {
        
    }
    
    // TODO: edit participants: Add a new member
    mutating func addToParticipants(add: Int) {
        
    }
    
    // TODO: edit participants: Remove a current member
    mutating func removeFromParticipants(remove: Int) {
        
    }
    
    // TODO: toggle with Tax state
    mutating func toggleTax() {
        self.withTax.toggle()
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
