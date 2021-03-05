//
//  DotsData.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation

/// Object contains all of the information of the app.
struct DotsData: Identifiable, Codable {
    
    ///ID of the current data.
    let id: UUID
    
    /// A list of Ints representing the members of the group.
    var group: [Int] = []
    
    /// A list of BillObjects containing the current bills.
    var bills: [BillObject] = []
    
    /// Options of the menu.
    var options: menuOption
    
    /// Initialize a DotsData object.
    /// - Parameters:
    ///   - id: id of the current data
    ///   - group: a list of Ints representing the members of the group
    ///   - bills: a list of BillObjects representing the bills of the group
    ///   - options: a list of options reprenting the options the user choose
    init(id: UUID = UUID(), group: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], bills: [BillObject] = [], options: menuOption = .init()) {
        self.id = id
        self.group = group
        self.bills = bills
        self.options = options
    }
    
    // MARK: Accessors
    // TODO: Get all members:
    /// Get the members of the current group.
    /// - Returns: a list of Ints that represent the members of the current group.
    func getGroup() -> [Int] {
        return group
    }
    
    /// Get bill index by the id of the current data.
    /// - Parameter id: id of the current data.
    /// - Returns: a list of ints that represent the bill index of current id.
    func getBillIndexByUUID(id: UUID) -> Int? {
        for i in self.bills.indices {
            if self.bills[i].id == id {
                return i
            }
        }
        return nil
    }
    // TODO: Access all paid bills
    
    /// Get all paid bills.
    /// - Returns: a list of BIllObjects that represent bills that have been marked as "paid".
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
    
    /// Get all bills that are unpaid.
    /// - Returns: a list of BillObects that represent bills that have not been marked as "paid".
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
    
    /// Get all bills in which a specific member participated in.
    /// - Parameter associatedWith: an Int representing the member that we want to get bills for.
    /// - Returns: a list of BIllObjects that the associatedWith member participated in.
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
    
    /// Get how current unpaid bills should be settled.
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
                
                if abs(creditors[cci].1 + debtors[cdi].1) < 0.01 {
                    temp += [(debtors[cdi].0, creditors[cci].1)]
                    creditors[cci].1 = 0
                    cdi += 1
                }
                else if creditors[cci].1 < (-1 * debtors[cdi].1) {
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
//                    fatalError("Should not be here")
                }
                settlementDict[creditors[cci].0] = temp
            }
            cci += 1
        }
        
        return settlementDict
    }
    
    /// Access the total amount of a member.
    /// - Parameter member: member index that represents a person.
    /// - Returns: Returns a double of member's total amount.
    func getMemberTotal(member: Int) -> Double {
	    var currTotal: Double = 0
	    for curr_bill in self.bills {
		    if !curr_bill.paid {
		    	currTotal += curr_bill.getMemberTotal(member: member)
		    }
	    }

	    return currTotal
    }
    
    // MARK: Mutators
    //TODO: add member to group
    
    /// Add member to group.
    /// - Parameter i: an Int corresponding to the member to be added.
    mutating func addToGroup(i: Int /* 0-9 */) {
        self.group.append(i)
        self.group.sort()
    }
    
    // TODO: remove a member from group
    
    /// Remove member from group.
    /// - Parameter i: an Int corresponding to the member to be removed.
    mutating func removeFromGroup(i: Int /* 0-9 */) {
        for index in 0...self.group.count-1 {
            if self.group[index] == i {
                self.group.remove(at: index)
                return
            }
        }
    }
    
    //TODO: Clear all bills
    
    /// Clear all of the accumulated bills.
    mutating func clearBills() {
        self.bills.removeAll()
    }
    
    /// Clear all paid bills.
    mutating func clearPaidBills() {
        let temp_bills = self.bills
        self.bills.removeAll()
        self.bills = temp_bills.filter(){$0.paid == false}
    }
    
    // TODO: Add new bill
    
    /// Add a new bill to the group.
    /// - Parameter bill: a BillObject of the bill to be added.
    mutating func addNewBill(bill: BillObject) {
        self.bills.append(bill)
        self.bills = self.bills.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    // TODO: Remove bill by id
    
    /// Remove bill from group.
    /// - Parameter id: a UUID that associated with the bill to be removed.
    mutating func removeBillById(id: UUID) {
        for index in 0..<self.bills.count {
            if self.bills[index].id == id {
                self.bills.remove(at: index)
                return
            }
        }
    }
    /// Deprecated. A sort function that will sort bills based on filter type.
    mutating func smartSort(filter: FilterType) {
        switch filter {
        case .Default:
            self.sortByDate()
            break
        case .Creditor:
            self.groupByInitiator()
            break
        case .Paid:
//            self.groupByUnpaid()
            break
        case .CreditorAndPaid:
            break
        }
    }
    
    /// Groups the list of bills based on initiator in ascending order.
    /// - Returns: a grouped list of new bills.
    mutating func groupByInitiator() {
        self.bills = self.bills.sorted { (a, b) -> Bool in
            if a.initiator == b.initiator {
                return a.date > b.date
            } else {
                return a.initiator < b.initiator
            }
        }
    }
    
//    mutating func groupByUnpaid() {
//        self.bills = self.bills.sorted { $0.paid && !$1.paid }
//    }
    
    /// Sort all bills by date.
    mutating func sortByDate() {
        self.bills = self.bills.sorted(by: { $0.date > $1.date })
    }
    
    /// Mark all bills as paid.
    mutating func markAllBillsAsPaid(){
        for currentBill in 0..<self.bills.count {
            self.bills[currentBill].markAsPaid()
        }
    }

}

extension DotsData {
    static var sample: DotsData = DotsData(group: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], bills: BillObject.sample)
}
