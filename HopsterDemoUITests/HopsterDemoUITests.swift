//
//  HopsterDemoUITests.swift
//  HopsterDemoUITests
//
//  Created by Doronin Denis on 8/17/16.
//  Copyright © 2016 HP. All rights reserved.
//

import XCTest

class HopsterDemoUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
   
        continueAfterFailure = false
        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
   
    
    func testMainMenu() {
    
        let collectionViewsQuery = XCUIApplication().collectionViews
        
        let cells = collectionViewsQuery.cells
        XCTAssertEqual(cells.count, 8, "found instead: \(cells.debugDescription)")

        let cellPingu = collectionViewsQuery.cells.staticTexts["Pingu"]
        let exists = NSPredicate(format: "exists == 1")
        
        expectationForPredicate(exists, evaluatedWithObject: cellPingu, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)
        
    }
    
}
