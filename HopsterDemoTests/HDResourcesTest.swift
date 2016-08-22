//
//  HDResourcesTest.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/22/16.
//  Copyright © 2016 HP. All rights reserved.
//

import XCTest

class HDResourcesTest: XCTestCase {
    
    var model: MenuModel?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.model =  MenuModel(aDelegate: self)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.model = nil
        super.tearDown()
    }
    
//    func testDummy() {
//        XCTAssert(false, "Testcase will fail - just to make sure, that all work as expected")
//    }
    
    func testResourcesExists() {
        
        let resources = self.model?.resourcesArray("resources")
        
        XCTAssert(resources != nil, "Resources plist should exist!")
    }
    
    func testResourcesItemsCount() {
        
        let resources = self.model?.resourcesArray("resources")
        
        // If you need to change count, please look at:
        // MenuLayout
        // MenuController
        // Change MenuLayoutDelegate and Layout for new items count
        XCTAssert(resources?.count == 8 , "Resources items count should be 8 for current implementation")
        
    }
    
    func testResourcesParsing() {
        
        let resources = self.model?.resourcesArray("resources")
        
        for persDict in resources! {
            
            let person = self.model?.parsePerson(persDict)
            
            XCTAssert(person != nil , "Resources item could not be nil")
            XCTAssert(person!.name.isEmpty == false , "Resources item name could not be nil")
            XCTAssert(person!.thumbnailURL.isEmpty == false , "Resources item thumbnailURL could not be nil")
            XCTAssert(person!.streamingLink.isEmpty == false , "Resources item streamingLink could not be nil")

        }

    }

    func testResourcesRemoteExits() {
        
        let resources = self.model?.resourcesArray("resources")
        
        for persDict in resources! {
            
            let person = self.model?.parsePerson(persDict)
            
            XCTAssert(person != nil , "Resources item could not be nil")
            XCTAssert(person!.thumbnailURL.isEmpty == false , "Resources item thumbnailURL could not be nil")
          
            let imageURL  = NSURL(string: person!.thumbnailURL)
            
            XCTAssert(imageURL != nil , "Resources item url could not be nil")
            
            let imageData = NSData(contentsOfURL:imageURL!)
            
            XCTAssert(imageData != nil , "Resources item data could not be nil")
            XCTAssert(imageData?.length > 0 , "Resources item data could not be empty")
            
            
            if imageData?.length > 0 {
                let image = UIImage(data:imageData!)
                 XCTAssert(image != nil , "Resources item image could not be nil")
                
            }

        }
        
    }
    
}

extension HDResourcesTest: MenuModelDelegate {
    
    // MenuModelDelegate methods
    func modelDidStartActivity(model: MenuModel) {
        
    }
    
    func modelDidFinishActivity(model: MenuModel) {
        
    }
    
}