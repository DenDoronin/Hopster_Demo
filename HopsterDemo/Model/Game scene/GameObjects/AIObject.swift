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
        return false
    }
    
    func canMoveRight() -> Bool {
        return false
    }
    
    func canMoveUp() -> Bool {
        return false
    }
    
    func canMoveDown() -> Bool {
        return false
    }
    
    func canJump() -> Bool {
        return false
    }
    
    func canRotate() -> Bool {
        return false
    }
    
}
