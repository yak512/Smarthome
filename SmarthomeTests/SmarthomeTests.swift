//
//  SmarthomeTests.swift
//  SmarthomeTests
//
//  Created by Yakoub on 26/10/2020.
//

import XCTest
@testable import Smarthome

class SmarthomeTests: XCTestCase {

    let service = DevicesService()
    
    // Just one test to show you i can test 
    func testGettingData() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        service.getDevicesData { (data, response) in
            XCTAssertTrue(response && data != nil)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
          if let error = error {
            XCTFail("error: \(error)")
          }
        }
    }

}
