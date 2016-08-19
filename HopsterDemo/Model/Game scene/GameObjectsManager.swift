//
//  GameObjectsManager.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class GameObjectsManager: NSObject {

    var objects: [GameObject] = []
    
    func objectDidChangeState(object: GameObject!) {
        
    }
    
    func addObject(anObject: GameObject) {
        objects.append(anObject)
    }
    
    func removeObject(anObject: GameObject) {
        if let index = self.objects.indexOf(anObject) {
            self.objects.removeAtIndex(index)
        }
    }
}
