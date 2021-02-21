//
//  EntryObject.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation


/// represents a single item entry.
struct EntryObject: Identifiable, Codable, Equatable {
    
    
    /// id of the entry
    let id: UUID
    
    /// a String representing the title of the entry
    var entryTitle: String
    
    /// a list of Ints representing the participants of the entry
    var participants: [Int]
    
    /// a Double representing the price per item of the entry
    var value: Double
    
    /// an Int representing the number of items of this entry
    var amount: Int
    
    /// a Boolean representing whether tax should be added for this entry
    var withTax: Bool
    
    
    /// initialize an EntryObject.
    /// - Parameters:
    ///   - id: id of the entry
    ///   - entryTitle: a String representing the title of the entry
    ///   - participants: a list of Ints representing the participants of the entry; default empty
    ///   - value: a Double representing the value of the item; default 0
    ///   - amount: an Int representing the amount of items of the entry; default 1
    ///   - withTax: a Boolean representing whether the entry should be taxed or not; default False
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
    
    /// get the total value of the entry.
    /// - Returns: a Double representing the total value of the entry
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
    
    /// get participants of the entry.
    /// - Returns: a list of Ints representing the participants of the entry
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
    
    /// change the title of the entry.
    /// - Parameter title: a String representing the new entry title
    mutating func setEntryTitle(title: String) {
        self.entryTitle = title
    }
    
    // TODO: set entry value
    
    /// change the value of an item of the entry
    /// - Parameter value: a Double representing the vnew alue of an item of the entry
    mutating func setEntryValue(value: Double) {
        self.value = value
    }
    
    // TODO: set entry amount (item number)
    
    /// change the amount of items of the entry
    /// - Parameter amount: an Int representing the new amount of items of the entry
    mutating func setEntryAmount(amount: Int) {
        self.amount = amount
    }
    
    // TODO: edit participants: Add a new member
    
    /// add a new participant to the entry.
    /// - Parameter add: an Int representing the new participant to be added
    mutating func addToParticipants(add: Int) {
        self.participants.append(add)
    }
    
    // TODO: edit participants: Remove a current member
    
    /// remove a participant from the entry.
    /// - Parameter remove: an Int representing the participant to be removed
    mutating func removeFromParticipants(remove: Int) {
        for i in 0...self.participants.count-1 {
            if self.participants[i] == remove {
                self.participants.remove(at: i)
                return
            }
        }
    }
    
    // TODO: toggle with Tax state
    
    /// change the withTax state
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
