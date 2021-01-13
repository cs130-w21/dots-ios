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
    var date: Date
    var attendees: [Int]
    var initiator: Int  // This number must be contained by attendees
    var paid: Bool
    var billAmount: Double
    var entries: [EntryObject]
    
    init(id: UUID = UUID(), title: String = "Untitled", date: Date = Date(), attendees: [Int] = [], initiator: Int = -1, paid: Bool = false, billAmount: Double = 0.0, entries: [EntryObject] = []) {
        self.id = id
        self.title = title
        self.date = date
        self.attendees = attendees
        self.initiator = initiator
        self.paid = paid
        self.billAmount = billAmount
        self.entries = entries
    }
    
    func getDate(style: DateFormatter.Style = DateFormatter.Style.medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self.date)
    }
}

extension BillObject {
    static var sample: [BillObject] {
        [
            BillObject(title: "Costco", date: Date() ,attendees: [0, 1, 2, 3, 5, 9], initiator: 2, paid: true, billAmount: 121.0, entries: EntryObject.sample),
            BillObject(title: "Walmart", attendees: [0, 1, 3, 5, 9], initiator: 9, paid: false, billAmount: 67.9, entries: EntryObject.sample),
            BillObject(title: "Costco 2", date: Date() ,attendees: [0, 1, 2, 3, 5, 9], initiator: 2, paid: true, billAmount: 121.0, entries: EntryObject.sample),
            BillObject(title: "Walmart 2", attendees: [0, 1, 3, 5, 9], initiator: 9, paid: false, billAmount: 67.9, entries: EntryObject.sample)
        ]
        
    }
}
