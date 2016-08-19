//
//  AIObject.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/19/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class AIObject: NSObject {
    
    func update () {
        // this is general point to handle logic state
    }
    
    func canMoveLeft() -> Bool {
        return true
    }
    
    func canMoveRight() -> Bool {
        return true
    }
    
    func canMoveUp() -> Bool {
        return true
    }
    
    func canMoveDown() -> Bool {
        return true
    }
    
    func canJump() -> Bool {
        return true
    }
    
    func canRotate() -> Bool {
        return true
    }
    
}
