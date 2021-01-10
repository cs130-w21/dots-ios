//
//  DotsData.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation

struct DotsData: Identifiable, Codable {
    let id: UUID
    var group: [Int] = []
    var bills: [BillObject] = []
   
    init(id: UUID = UUID(), group: [Int] = [], bills: [BillObject] = []) {
        self.id = id
        self.group = group
        self.bills = bills
    }
}

extension DotsData {
    static var sample: DotsData = DotsData(group: [0, 1, 2, 3, 5, 6, 9], bills: BillObject.sample)
}
