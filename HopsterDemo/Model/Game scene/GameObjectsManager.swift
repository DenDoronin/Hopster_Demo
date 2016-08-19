//
//  GameObjectsManager.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class GameObjectsManager: NSObject {

    weak var player: GameObject?
    var objects: [GameObject] = []
    
    func objectDidChangeState(object: GameObject!) {
        
    }
    
    func addObject(anObject: GameObject) {
        if anObject.isPlayer {
            // drop previous player
            if (self.player != nil && anObject != self.player) {
                self.player!.isPlayer = false
            }
            
            self.player = anObject
        }
        objects.append(anObject)
    }
    
    func removeObject(anObject: GameObject) {
        if let index = self.objects.indexOf(anObject) {
            self.objects.removeAtIndex(index)
        }
    }
    
}
