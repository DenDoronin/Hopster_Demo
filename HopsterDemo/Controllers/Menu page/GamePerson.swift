//
//  GamePerson.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/21/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class GamePerson: NSObject {

    var name: String
    var thumbnailURL: String
    var streamingLink: String
    var thumbnailImage: UIImage?
    
    init(aName:String, aThumURL:String, aLink:String) {
        
        self.name = aName
        self.thumbnailURL = aThumURL
        self.streamingLink = aLink
        
    }
    
}
