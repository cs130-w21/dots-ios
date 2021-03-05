//
//  EntryObject.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation


/// Represents a single item entry.
struct EntryObject: Identifiable, Codable, Equatable {
    
    
    /// Id of the entry.
    let id: UUID
    
    /// A String representing the title of the entry.
    var entryTitle: String
    
    /// A list of Ints representing the participants of the entry.
    var participants: [Int]
    
    /// A Double representing the price per item of the entry.
    var value: Double
    
    /// An Int representing the number of items of this entry.
    var amount: Int
    
    /// A Boolean representing whether tax should be added for this entry.
    var withTax: Bool
    
    
    /// Initialize an EntryObject.
    /// - Parameters:
    ///   - id: id of the entry.
    ///   - entryTitle: a String representing the title of the entry.
    ///   - participants: a list of Ints representing the participants of the entry; default empty.
    ///   - value: a Double representing the value of the item; default 0.
    ///   - amount: an Int representing the amount of items of the entry; default 1.
    ///   - withTax: a Boolean representing whether the entry should be taxed or not; default False.
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
    
    /// Get the total value of the entry.
    /// - Returns: a Double representing the total value of the entry.
    func getEntryTotal() -> Double {
//    func getEntryTotal(taxRate: Double) -> Double {
//        if withTax {
//            return value * Double(amount) * (1 + taxRate)
//        }
//        else {
            return value * Double(amount)
//        }
    }
    
    // TODO: get participants
    
    /// Get participants of the entry.
    /// - Returns: a list of Ints representing the participants of the entry.
    func getParticipants() -> [Int] {
        return participants
    }
    
    func getMemberTotal(member: Int) -> Double {
	    if participants.contains(member) {
		    return (-1 * getEntryTotal()/Double(participants.count))
	    }
	    else {
		    return 0
	    }
    }
    
    // MARK: Mutators
    
    // TODO: set entry title
    
    /// Change the title of the entry.
    /// - Parameter title: a String representing the new entry title.
    mutating func setEntryTitle(title: String) {
        self.entryTitle = title
    }
    
    // TODO: set entry value
    
    /// Change the value of an item of the entry.
    /// - Parameter value: a Double representing the new value of an item of the entry.
    mutating func setEntryValue(value: Double) {
        self.value = value
    }
    
    // TODO: set entry amount (item number)
    
    /// Change the amount of items of the entry.
    /// - Parameter amount: an Int representing the new amount of items of the entry.
    mutating func setEntryAmount(amount: Int) {
        self.amount = amount
    }
    
    // TODO: edit participants: Add a new member
    
    /// Add a new participant to the entry.
    /// - Parameter add: an Int representing the new participant to be added.
    mutating func addToParticipants(add: Int) {
        self.participants.append(add)
    }
    
    // TODO: edit participants: Remove a current member
    
    /// Remove a participant from the entry.
    /// - Parameter remove: an Int representing the participant to be removed.
    mutating func removeFromParticipants(remove: Int) {
        for i in 0...self.participants.count-1 {
            if self.participants[i] == remove {
                self.participants.remove(at: i)
                return
            }
        }
    }
    
    // TODO: toggle with Tax state
    
    /// Change the withTax state.
    mutating func toggleTax() {
        self.withTax.toggle()
    }
}


extension EntryObject {
    static var sample: [[EntryObject]] {
        [
            [
                EntryObject(entryTitle: "A White Owl", participants: [5], value: 199, amount: 1),
                EntryObject(entryTitle: "Nimbus 2021", participants: [1], value: 2500, amount: 1, withTax: true),
                EntryObject(entryTitle: "Butter Beer", participants: [0, 1, 9], value: 19.99, amount: 3, withTax: false),
                EntryObject(entryTitle: "Floo Pow", participants: [0, 2, 5, 6], value: 14.99, amount: 4, withTax: true),
                EntryObject(entryTitle: "The Monster Book", participants: [8], value: 59.99, amount: 1, withTax: true)
            ],
            [
                EntryObject(entryTitle: "Water no ice", participants: [5], value: 99.99, amount: 1),
                EntryObject(entryTitle: "Wired Airpods", participants: [3, 7], value: 18.99, amount: 1, withTax: true),
                EntryObject(entryTitle: "Cat ear headphones", participants: [3, 6], value: 19.99, amount: 3, withTax: false),
                EntryObject(entryTitle: "Cyberpunk 2077", participants: [3, 4, 5, 6], value: 59.99, amount: 4, withTax: true),
                EntryObject(entryTitle: "Play Station 6", participants: [6, 7], value: 400, amount: 1, withTax: true)
            ]
        ]
    }
}
