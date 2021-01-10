//
//  Bill.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation

// MARK: Create a BillObject
struct BillObject: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Int]
    var initiator: Int  // This number must be contained by attendees
    var paid: Bool
    var billAmount: Double
    var entries: [EntryObject]
    
    init(id: UUID = UUID(), title: String = "Untitled", attendees: [Int] = [], initiator: Int = -1, paid: Bool = false, billAmount: Double = 0.0, entries: [EntryObject] = []) {
        self.id = id
        self.title = title
        self.attendees = attendees
        self.initiator = initiator
        self.paid = paid
        self.billAmount = billAmount
        self.entries = entries
    }
}
