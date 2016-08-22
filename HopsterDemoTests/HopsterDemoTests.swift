//
//  HopsterDemoTests.swift
//  HopsterDemoTests
//
//  Created by Doronin Denis on 8/17/16.
//  Copyright © 2016 HP. All rights reserved.
//

import XCTest
@testable import HopsterDemo

class HopsterDemoTests: XCTestCase {
    
    var model: MenuModel?
    
    var asyncExpectationStartActivity: XCTestExpectation?
    var asyncExpectationFinishActivity: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.model =  MenuModel(aDelegate: self)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.model = nil
        self.asyncExpectationStartActivity = nil
        self.asyncExpectationFinishActivity = nil
        super.tearDown()
    }

    
    func testModelDidStartActivity() {
        
        self.asyncExpectationStartActivity = expectationWithDescription("MenuModelStart")

        self.model!.populateModel()
        self.waitForExpectationsWithTimeout(5) { error in
            XCTAssert(error == nil, "Failed to start activity")
        }

    }
    
    func testModelDidFinishActivity() {
        
        self.asyncExpectationFinishActivity = expectationWithDescription("MenuModelFinish")
        
        self.model!.populateModel()
        self.waitForExpectationsWithTimeout(20) { error in
            XCTAssert(error == nil, "Failed to finish activity")
            XCTAssert(self.model?.objects != nil, "Datasource should not be nil")
        }
        
    }
        
}

extension HopsterDemoTests: MenuModelDelegate {
    
    // MenuModelDelegate methods
    func modelDidStartActivity(model: MenuModel) {
        self.asyncExpectationStartActivity?.fulfill()
    }
    
    func modelDidFinishActivity(model: MenuModel) {
        self.asyncExpectationFinishActivity?.fulfill()
    }
    
}
