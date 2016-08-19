//
//  AIEngine.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class AIEngine: NSObject {
    
    weak var objectManager: GameObjectsManager?
    
    init(anObjectManager: GameObjectsManager) {
        self.objectManager = anObjectManager
    }
    
    func update() {
        // override this method and handle the logic of object interactions
        // check triggers and so on
    }
}
