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
        self.position.x -= self.size.width
    }
    
    override func moveRight() {
        self.position.x += self.size.width
    }

    
}
