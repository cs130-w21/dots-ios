//
//  DotsData.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation

///contains all of the information, including all bills, of the user
struct DotsData: Identifiable, Codable {
    
    ///id of the current data
    let id: UUID
    
    /// a list of Ints representing the members of the group
    var group: [Int] = []
    
    /// a list of BillObjects containing the current bills
    var bills: [BillObject] = []
    
    
    /// initialize a DotsData object.
    /// - Parameters:
    ///   - id: id of the current data
    ///   - group: a list of Ints representing the members of the group
    ///   - bills: a list of BillObjects representing the bills of the group
    init(id: UUID = UUID(), group: [Int] = [0, 1, 2, 3, 5, 6, 9], bills: [BillObject] = BillObject.sample) {
        self.id = id
        self.group = group
        self.bills = bills
    }
    
    // MARK: Accessors
    // TODO: Get all members:
    /// get the members of the current group
    /// - Returns: a list of Ints that represent the members of the current group
    func getGroup() -> [Int] {
        return group
    }
    // TODO: Access all paid bills
    
    /// get all paid bills
    /// - Returns: a list of BIllObjects that represent bills that have been marked as "paid"
    func getPaidBills() -> [BillObject] {
        var paidBills: [BillObject] = []
        for curr_bill in self.bills {
            if curr_bill.paid {
                paidBills.append(curr_bill)
                continue
            }
        }
        return paidBills
    }
    
    // TODO: Get all unpaid bills
    
    /// get all bills that are unpaid
    /// - Returns: a list of BillObects that represent bills that have not been marked as "paid"
    func getUnpaidBills() -> [BillObject] {
        var unpaidBills: [BillObject] = []
        for curr_bill in self.bills {
            if !curr_bill.paid {
                unpaidBills.append(curr_bill)
                continue
            }
        }
        return unpaidBills
    }
    
    // TODO: get all bills that are associated with the specified dot index (member)
    
    /// get all bills in which a specific member participated in
    /// - Parameter associatedWith: an Int representing the member that we want to get bills for
    /// - Returns: a list of BIllObjects that the associatedWith member participated in
    func filterBills(associatedWith: Int) -> [BillObject] {
        var associatedBills: [BillObject] = []
        for curr_bill in self.bills {
            if curr_bill.attendees.contains(associatedWith) {
                associatedBills.append(curr_bill)
                continue
            }
        }
        return associatedBills
    }
    
    
    // Bills settlement
    
    /// get how current unpaid bills should be settled
    /// - Returns: a list of tuples (int, Int, Double). The first Int is the member who should be paid back; the second Int is the member who should pay them back; the Double is the amount to be paid back.
    func calculate_settlement() -> [Int: [(Int, Double)]] {
        var mt = [Double] (repeating: 0.0, count: 10) //master table
        
        var settlementDict: [Int: [(Int, Double)]] = [:]
        
        for curr_bill in self.bills {
            if !curr_bill.paid {
                let temp = curr_bill.settleBill()
                for (i, _) in mt.enumerated() {
                    mt[i] += temp[i]
                }
            }
        }
        
        var creditors = mt.enumerated().filter {$0.element > 0}.sorted(by: {$0.element > $1.element}) //(creditor, $)
        var debtors = mt.enumerated().filter {$0.element < 0}.sorted(by: {$0.element < $1.element}) //(debtor, $ owed)
        
        var cci = 0 //curr creditor index
        var cdi = 0 //curr debtor index
        
        while cci < creditors.count {
            var temp: [(Int, Double)] = []
            while creditors[cci].1 > 0 {
                if creditors[cci].1 < (-1 * debtors[cdi].1) {
                    temp += [(debtors[cdi].0, creditors[cci].1)]
                    debtors[cdi].1 += creditors[cci].1
                    creditors[cci].1 = 0
                }
                else if creditors[cci].1 > (-1 * debtors[cdi].1) {
                    temp += [(debtors[cdi].0, (-1 * debtors[cdi].1))]
                    creditors[cci].1 -= (-1 * debtors[cdi].1)
                    cdi += 1
                }
                else {
                    temp += [(debtors[cdi].0, creditors[cci].1)]
                    creditors[cci].1 = 0
                    cdi += 1
                }
                settlementDict[creditors[cci].0] = temp
            }
            cci += 1
        }
        
        return settlementDict
    }
    
    // MARK: Mutators
    //TODO: add member to group
    
    /// add member to group
    /// - Parameter i: an Int corresponding to the member to be added
    mutating func addToGroup(i: Int /* 0-9 */) {
        self.group.append(i)
        self.group.sort()
    }
    
    // TODO: remove a member from group
    
    /// remove member from group
    /// - Parameter i: an Int corresponding to the member to be removed
    mutating func removeFromGroup(i: Int /* 0-9 */) {
        for index in 0...self.group.count-1 {
            if self.group[index] == i {
                self.group.remove(at: index)
                return
            }
        }
    }
    
    //TODO: Clear all bills
    
    /// clear all of the accumulated bills
    mutating func clearBills() {
        self.bills = []
    }
    
    // TODO: Add new bill
    
    /// add a new bill to the group
    /// - Parameter bill: a BillObject of the bill to be added
    mutating func addNewBill(bill: BillObject) {
        self.bills.append(bill)
        self.bills = self.bills.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    // TODO: Remove bill by id
    
    /// remove bill from group
    /// - Parameter id: a UUID that associated with the bill to be removed
    mutating func removeBillById(id: UUID) {
        for index in 0...self.bills.count-1 {
            if self.bills[index].id == id {
                self.bills.remove(at: index)
                return
            }
        }
    }
    
    /// groups the list of bills based on initiator in ascending order.
    /// - Returns: a grouped list of new bills 
    mutating func groupByInitiator() -> [BillObject] {
        return self.bills.sorted(by: { $0.initiator < $1.initiator })
    }
    
}

extension DotsData {
    static var sample: DotsData = DotsData(group: [0, 1, 2, 3, 5, 6, 9], bills: BillObject.sample)
}
