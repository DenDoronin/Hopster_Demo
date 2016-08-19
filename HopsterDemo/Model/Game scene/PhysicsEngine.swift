//
//  PhysicsEngine.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class PhysicsEngine: NSObject {
    
    weak var objectManager: GameObjectsManager?
    
    init(anObjectManager: GameObjectsManager) {
        self.objectManager = anObjectManager
    }
    
    func update() {
        //override this method and handle base physics for your game world
        
    }
}
