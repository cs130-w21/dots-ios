//
//  DotsUnitTests.swift
//  DotsUnitTests
//
//  Created by Jack Zhao on 2/25/21.
//

import XCTest
import LocalAuthentication
@testable import Dots

class DotsUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAuthenticator() {
        let authenticator = Authenticator()
//        authenticator.context = StubLAContext()
        authenticator.authenticate()
        authenticator.lock()
        authenticator.unlock()
    }
    
    func testDotsDataObject() {
        var mainData = DotsData()
        XCTAssertEqual(mainData.getGroup(), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        mainData.addToGroup(i: 10)
        XCTAssertEqual(mainData.getGroup(), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        mainData.removeFromGroup(i: 10)
        XCTAssertEqual(mainData.getGroup(), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        mainData.clearBills()
        XCTAssertEqual(mainData.bills.count, 0, "total bill number is not 0 after clear")
        
        // Test add bill
        let testUUID = UUID()
        let testBill = BillObject(id: testUUID, title: "Test Bill", date: Date(), attendees: [0, 2, 9], initiator: 9, paid: false, tax: 10, entries: [])
        
        mainData.addNewBill(bill: testBill)
        XCTAssertEqual(mainData.bills.count, 1)
        
        XCTAssertEqual(mainData.filterBills(associatedWith: 0), [testBill])
        XCTAssertEqual(mainData.filterBills(associatedWith: 8), [])
        
        // Test: removeBillById
        // Case: Existing UUID/Non existing UUID
        mainData.removeBillById(id: testUUID)
        mainData.removeBillById(id: UUID())
        // Result
        XCTAssertEqual(mainData.bills.count, 0)
        
        mainData.addNewBill(bill: testBill)
        mainData.addNewBill(bill: BillObject(id: UUID(), title: "Test Bill", date: Date().addingTimeInterval(200), attendees: [0, 2, 9], initiator: 9, paid: true, tax: 10, entries: []))
        
        mainData.sortByDate()
        XCTAssertEqual(mainData.getPaidBills().count, 1)
        // Test get by Bill UUID
        XCTAssertEqual(mainData.getBillIndexByUUID(id: testUUID), 1)
        XCTAssertEqual(mainData.getBillIndexByUUID(id: UUID()), nil)
        
        // Now, one is paid and one is unpaid
        mainData.clearPaidBills()
        
        // The only paid is removed
        XCTAssertEqual(mainData.bills.count, 1)
        
        XCTAssertEqual(mainData.getPaidBills().count, 0)
        XCTAssertEqual(mainData.getUnpaidBills().count, 1)
        
        mainData.markAllBillsAsPaid()
        XCTAssertEqual(mainData.getPaidBills().count, 1)
        XCTAssertEqual(mainData.getUnpaidBills().count, 0)
        
        mainData.clearPaidBills()
        XCTAssertEqual(mainData.bills.count, 0)
        mainData.groupByInitiator()
        
        XCTAssertEqual(mainData.getMemberTotal(member: 0), 0)
        
        // Test settlement function
        let testUUID1 = UUID()
        var testBill1 = BillObject(id: testUUID1, title: "Test Bill 1", date: Date(), attendees: [0, 1, 2, 3], initiator: 0, paid: false, tax: 0, entries: [])
        testBill1.addNewEntry(entryTitle: "Test Entry 1", participants: [0, 1, 2, 3], value: 10, amount: 8, withTax: false)
        testBill1.addNewEntry(entryTitle: "Test Entry 2", participants: [1, 3], value: 10, amount: 1, withTax: false)
        
        let testUUID2 = UUID()
        let testBill2 = BillObject(id: testUUID2, title: "Test Bill 2", date: Date(), attendees: [3, 4, 5, 6], initiator: 3, paid: true, tax: 20, entries: [])
        
        mainData.addNewBill(bill: testBill1)
        mainData.addNewBill(bill: testBill2)
        
        //let settlementDict: [Int: [(Int, Double)]] = [0: [(1, 25.0), (2, 20.0),(3, 25.0)]]
        
        let resultDict = mainData.calculate_settlement()
        let resultArr = resultDict[0]
        
        XCTAssertTrue(((resultArr?.contains(where: {$0 == (1, 25.0)})) != nil))
        XCTAssertTrue(((resultArr?.contains(where: {$0 == (2, 20.0)})) != nil))
        XCTAssertTrue(((resultArr?.contains(where: {$0 == (3, 25.0)})) != nil))
        
        let _ = DotsData.sample
    }
    
    func testBillObject() {
        let testUUID = UUID()
        let testTitle = "Title"
        let date = Date()
        let attendees = [1, 2, 3]
        let initiator = 3
        let tax = 10.5
        var bill = BillObject(id: testUUID, title: "ABC", date: date, attendees: attendees, initiator: initiator, paid: false, tax: tax, billAmount: 0, entries: [])
        
        XCTAssertEqual(bill.getAttendees(), attendees)
        XCTAssertEqual(bill.getInitiator(), initiator)
        XCTAssertEqual(bill.title, "ABC")
        
        bill.setTitle(newTitle: testTitle)
        XCTAssertEqual(bill.title, testTitle)
        
        XCTAssertEqual(bill.involvedEntries(with: 1), [])
        XCTAssertEqual(bill.getBillTotal(), 0)
        XCTAssertEqual(bill.getMemberTotal(member: 2), 0)
        
        //change tax rate to 10
        bill.setTaxRate(tax: 10)
        XCTAssertEqual(bill.taxRate, 10)
        
        //change initiator to 2
        bill.setInitiator(initiator: 2)
        XCTAssertEqual(bill.getInitiator(), 2)
        
        //chnage participants to [2, 3, 4, 5]
        bill.setParticipants(participants: [2, 3, 4, 5])
        XCTAssertEqual(bill.getAttendees(), [2, 3, 4, 5])
        
        //add participant 8
        bill.addParticipant(participant: 8)
        XCTAssertEqual(bill.getAttendees(), [2, 3, 4, 5, 8])
        
        //remove participant 8
        bill.removeParticipant(at: 4)
        XCTAssertEqual(bill.getAttendees(), [2, 3, 4, 5])
        
        //test w/ entries
        let testEntryUUID = UUID()
        let testEntry = EntryObject(id: testEntryUUID, entryTitle: "Test Entry", participants: [2, 3], value: 10, amount: 2, withTax: true)
        bill.addNewEntry(entry: testEntry)
        
        bill.addNewEntry(entryTitle: "Test Entry 2", participants: [3, 4, 5], value: 30, amount: 1, withTax: false)
        
        XCTAssertEqual(bill.involvedEntries(with: 2), [testEntry])
        XCTAssertEqual(bill.getBillTotal(), 52)
        XCTAssertEqual(bill.getMemberTotal(member: 3), -21)
        
        XCTAssertEqual(bill.settleBill(), [0, 0, 41, -21, -10, -10, 0, 0, 0, 0])
        
        bill.markAsPaid()
        XCTAssertEqual(bill.paid, true)
        bill.setPaidStatus(isPaid: false)
        XCTAssertEqual(bill.paid, false)
        
        //clear entries
        bill.removeEntry(at: 1)
        XCTAssertEqual(bill.getBillTotal(), 22)
        
        bill.clearEntries()
        XCTAssertEqual(bill.getBillTotal(), 0)
    }
    
    func testEntryObject() {
        let entryUUID = UUID()
        let testEntryTitle = "Pizza"
        let testParticipants = [1, 2, 3]
        let testValue = 10.0
        let testAmount = 3
        
        var entry = EntryObject(id: entryUUID, entryTitle: "Soda", participants:testParticipants, value: 0, amount: 0, withTax: false)
        
        XCTAssertEqual(entry.getEntryTotal(), 0)
        XCTAssertEqual(entry.getParticipants(), testParticipants)
        XCTAssertEqual(entry.getMemberTotal(member: 1), 0)
        XCTAssertEqual(entry.getMemberTotal(member: 8), 0)
        
        entry.setEntryTitle(title: testEntryTitle)
        entry.setEntryValue(value: testValue)
        entry.setEntryAmount(amount: testAmount)
        
        XCTAssertEqual(entry.entryTitle, testEntryTitle)
        XCTAssertEqual(entry.getEntryTotal(), 30)
        XCTAssertEqual(entry.getMemberTotal(member: 2), -10)
       
        entry.addToParticipants(add: 4)
        XCTAssertEqual(entry.getParticipants(), [1, 2, 3, 4])
        
        entry.removeFromParticipants(remove: 3)
        XCTAssertEqual(entry.getParticipants(), [1, 2, 4])
        
        entry.toggleTax()
        XCTAssertEqual(entry.withTax, true)
    }
}
