//
//  SmarthomeUITests.swift
//  SmarthomeUITests
//
//  Created by Yakoub on 26/10/2020.
//

import XCTest

class SmarthomeUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        //var continueAfterFailure = false
        
        app = XCUIApplication()
        
        app.launchArguments.append("ui-testing")
        sleep(1)
       // app.buttons["SearchButton"].tap()

    }
    
    
    func testShowDeviceButton() {
        app = XCUIApplication()
        app.launch()
        app.buttons["Show my Devices"].tap()
        XCTAssert(app.buttons["Show my Devices"].exists)
        
    }
    
    func testSelectACell() {
        app = XCUIApplication()
        app.launch()
        sleep(1)
        app.buttons["Show my Devices"].tap()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        sleep(2)


        
    }
}
