//
//  BuoyFinderDataKit_iOSTests.swift
//  BuoyFinderDataKit-iOSTests
//
//  Created by Matthew Iannucci on 11/28/16.
//  Copyright © 2016 Matthew Iannucci. All rights reserved.
//

import XCTest
@testable import BuoyFinderDataKit

class BuoyFinderDataKit_iOSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchAllStations() {
        let fetchExpectation = expectation(description: "Wait for buoy stations to fetch and parse")
        
        BuoyNetworkClient.fetchAllBuoys { (buoys) in
            XCTAssert((buoys?.count)! > 0)
            
            fetchExpectation.fulfill()
        }
        
        // Wait for the expectations to finish up
        waitForExpectations(timeout: 10.0, handler:nil)
    }
    
    func testFetchStationInfo() {
        let fetchExpectation = expectation(description: "Wait for the buoy station info to fetch and parse")
        
        BuoyNetworkClient.fetchBuoyStationInfo(stationID: "44097", callback: {
            (buoy) in
            
            XCTAssert(buoy != nil)
            
            fetchExpectation.fulfill()
        })
        
        // Wait for the expectations to finish up
        waitForExpectations(timeout: 10.0, handler:nil)
    }
}
