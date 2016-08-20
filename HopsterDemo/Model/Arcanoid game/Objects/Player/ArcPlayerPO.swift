//
//  ArcPlayerPO.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/19/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class ArcPlayerPO: PhysicsObject {

    override func moveLeft() {
        // basic object is statis - it does not responde to events
        self.position.x -= self.size.width
    }
    
    override func moveRight() {
        // basic object is statis - it does not responde to events
        self.position.x += self.size.width
    }

    
}
