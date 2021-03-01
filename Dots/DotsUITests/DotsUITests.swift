//
//  DotsUITests.swift
//  DotsUITests
//
//  Created by Jack Zhao on 2/20/21.
//

import XCTest

class DotsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.buttons["line.horizontal.3"].tap()
        XCTAssertFalse(app.staticTexts["No Bills"].isEnabled)
        
        app.buttons["arrow.backward"].tap()
        XCTAssertTrue(app.staticTexts["No Bills"].isEnabled)
        
        app.buttons["Calculate"].tap()
        XCTAssertFalse(app.staticTexts["No Bills"].isEnabled)
        
        app.buttons["arrow.left"].tap()
        XCTAssertTrue(app.staticTexts["No Bills"].isEnabled)
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEntry() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["plus"].tap()
        
        app.tapAtPosition(position: CGPoint(x: 95, y: 279))
        app.tapAtPosition(position: CGPoint(x: 211, y: 279))
        XCTAssertFalse(app.buttons["Done"].isEnabled)
        app.longPressAtPosition(position: CGPoint(x: 37, y: 279))
        XCTAssertTrue(app.buttons["Done"].isEnabled)
//
        let titleField = app.textFields["titleTextField"]
        titleField.tap()
        titleField.typeText("Test Bill Title")
        titleField.typeText(XCUIKeyboardKey.return.rawValue)
        
        let taxField = app.textFields["taxTextField"]
        taxField.tap()
        taxField.typeText("10.25")
        taxField.typeText(XCUIKeyboardKey.return.rawValue)
        
        app.buttons["Done"].tap()
        
        app.staticTexts["Test Bill Title"].tap()
        
        // Mark: Enter Add Entry
        let addEntry = app.buttons["Add Entry"]
        let entryTitleField = app.textFields["titleTextField"]
        let priceField = app.textFields["priceTextField"]
        let quantityField = app.textFields["quantityTextField"]
//        let taxSwitch = app.switches["taxSwitch"]
        
        addEntry.tap()
        app.images["dot-0"].tap()
        XCTAssertEqual("largecircle.fill.circle", app.images["dot-0"].label)
        
        app.images["dot-1"].tap()
        XCTAssertEqual("largecircle.fill.circle", app.images["dot-1"].label)
        app.images["dot-1"].tap()
        XCTAssertEqual("circle.fill", app.images["dot-1"].label)
        app.images["dot-3"].tap()
        
        priceField.tap()
        priceField.typeText("12")
        priceField.typeText(XCUIKeyboardKey.return.rawValue)
        
        quantityField.tap()
        quantityField.typeText("2")
        quantityField.typeText(XCUIKeyboardKey.return.rawValue)
        
        app.buttons["Done"].tap()
        
        XCTAssert(app.staticTexts["$ 24.00"].exists)
        addEntry.tap()
        app.images["dot-0"].tap()
        app.images["dot-1"].tap()
        app.images["dot-3"].tap()
        
        priceField.tap()
        priceField.typeText("34")
        priceField.typeText(XCUIKeyboardKey.return.rawValue)
        
        quantityField.tap()
        quantityField.typeText("10")
        quantityField.typeText(XCUIKeyboardKey.return.rawValue)
        
        entryTitleField.tap()
        entryTitleField.typeText("Test item title")
        entryTitleField.typeText(XCUIKeyboardKey.return.rawValue)
        
        app.switches["taxSwitch"].tap()
        app.buttons["Done"].tap()
        app.buttons["xmark.circle.fill"].tap()
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}

extension XCUIElement /*TapAtPosition*/ {
    func tapAtPosition(position: CGPoint) {
        let cooridnate = self.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0)).withOffset(CGVector(dx: position.x, dy: position.y))
        cooridnate.tap()
    }
    func longPressAtPosition(position: CGPoint) {
        let cooridnate = self.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0)).withOffset(CGVector(dx: position.x, dy: position.y))
        cooridnate.press(forDuration: 2.0)
    }
}
