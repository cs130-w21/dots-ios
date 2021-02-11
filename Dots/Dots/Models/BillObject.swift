//
//  Bill.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation

// MARK: Create a BillObject
struct BillObject: Identifiable, Codable, Equatable {
    static func == (lhs: BillObject, rhs: BillObject) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: UUID
    var title: String
    var date: Date
    var attendees: [Int]
    var initiator: Int  // This number must be contained by attendees
    var paid: Bool
    var taxRate: Double
    var billAmount: Double /* Depricated, no longer in use. Use self.getBillTotal() instead */
    var entries: [EntryObject]
    
    init(id: UUID = UUID(), title: String = "Untitled", date: Date = Date(), attendees: [Int] = [], initiator: Int = -1, paid: Bool = false, tax: Double = 0.0, billAmount: Double = 0.0, entries: [EntryObject] = []) {
        self.id = id
        self.title = title
        self.date = date
        self.attendees = attendees
        self.initiator = initiator
        self.paid = paid
        self.taxRate = tax
        self.billAmount = billAmount /* Depricated, no longer in use. Use self.getBillTotal() instead */
        self.entries = entries
    }
    

    func getDate(style: DateFormatter.Style = DateFormatter.Style.medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self.date)
    }
    
    // MARK: Accessors
    
    // TODO: Get all entries associated with given member (dot index)
    func involvedEntries(with: Int) -> [EntryObject] {
        var involved_entries: [EntryObject] = []
        
        for cur_entry in self.entries {
            for cur_participant in cur_entry.getParticipants(){
                if with == cur_participant {
                    involved_entries.append(cur_entry)
                    continue
                }
            }
        }
        // with: an integer representing the target member
        // return: all entries (in a list) that have this target as a participant
        return involved_entries
    }
    
    // TODO: Settle the amount due for one bill, calculation should base on current entries.
    // note: 请自由发挥
    func settleBill() -> [Double] {
        var mt = [Double] (repeating: 0.0, count: 10)
        
        for curr_entry in self.entries {
            let per_person = (curr_entry.getEntryTotal())/Double (curr_entry.participants.count)
            for i in curr_entry.participants {
                mt[i] -= per_person
            }
        }
        
        mt[self.initiator] += self.getBillTotal()
        
        return mt
    }
    
    func getInitiator() -> Int {
        return self.initiator
    }
    
    func getAttendees() -> [Int] {
        return self.attendees
    }
    
    // TODO: Gather all entries and calculate a bill total, in Double Type
    // Don't Forget the tax!
    
    func getBillTotal() -> Double {
        var total : Double = 0.0;
        //assume tax is included in getEntryTotal() below
        for cur_entry in self.entries {
            total = total + Double(cur_entry.getEntryTotal())
        }
         //if tax is not included in getEntryTotal()  then comment above, uncomment below
         
         /*
         for cur_entry in self.entries {
            total = total + Double(cur_entry.getEntryTotal()*(1 + self.taxRate))
         }
         */
        return total
    }
    
    // MARK: Muattors
    // TODO: clear all entries
    mutating func clearEntries(){
        self.entries = []
    }
    
    mutating func markAsPaid() {
        self.paid = true
    }
    
    // TODO: set title
    mutating func setTitle(newTitle: String) {
        self.title = newTitle
    
    }
    
    // TODO: modify bill date
    mutating func setDate(date: Date) {
        self.date = date
    }
    
    // TODO: set tax rate
    mutating func setTaxRate(tax: Double) {
        self.taxRate = tax
    }
    
    // TODO: change initiator
    mutating func setInitiator(initiator: Int) {
        self.initiator = initiator
        
    }
    
    //TODO: change participants
    mutating func setParticipants(participants: [Int]) {
        self.attendees = participants
        
    }
    
    //TODO: change participants
    mutating func addParticipant(participant: Int) {
        self.attendees.append(participant)
        self.attendees.sort()
    }
    
    // TODO: Edit participants: remove at a designated index
    mutating func removeParticipant(at: Int) {
        self.attendees.remove(at: at)
    }
    
    // TODO: add a new entry
    mutating func addNewEntry(entry: EntryObject) {
        self.entries.append(entry)
        
        // EntryObject(id: <#T##UUID#>, entryTitle: <#T##String#>, participants: <#T##[Int]#>, value: <#T##Double#>, amount: <#T##Int#>, withTax: <#T##Bool#>)
    }
    
    // TODO: add a new entry
    mutating func addNewEntry(entryTitle: String, participants: [Int], value: Double, amount: Int, withTax: Bool) {
        self.entries.append(EntryObject(entryTitle: entryTitle, participants: participants, value: value, amount: amount, withTax: withTax))
    }
    
    // TODO: remove an entry at a designated index
    mutating func removeEntry(at: Int) {
        self.entries.remove(at: at)
    }
    // MARK: END OF CLASS
}
    
    
extension BillObject {
    static var sample: [BillObject] {
        [
            BillObject(title: "Costco", date: Date() ,attendees: [0, 1, 2, 3, 5, 9], initiator: 2, paid: true, billAmount: 121.0, entries: EntryObject.sample),
            BillObject(title: "Walmart", attendees: [0, 1, 3, 5, 9], initiator: 9, paid: false, billAmount: 67.9, entries: EntryObject.sample),
            BillObject(title: "Bruin Store", date: Date() ,attendees: [2, 4, 5, 9], initiator: 4, paid: true, billAmount: 58.9, entries: EntryObject.sample),
            BillObject(title: "99 Ranch", attendees: [5, 7, 9], initiator: 9, paid: false, billAmount: 89.4, entries: EntryObject.sample)
        ]
        
    }
}
