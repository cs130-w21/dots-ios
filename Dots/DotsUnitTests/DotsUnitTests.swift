//
//  DotsUnitTests.swift
//  DotsUnitTests
//
//  Created by Jack Zhao on 2/25/21.
//

import XCTest
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
    }
}
