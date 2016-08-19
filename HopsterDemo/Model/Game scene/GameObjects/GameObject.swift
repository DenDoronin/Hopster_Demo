//
//  GameObject.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class GameObject: NSObject {
    
    /// The common way to determ what's object is a player -
    /// just bool flag
    /// this is helpful, because we can switch over the scene
    /// using only flag, and logic will remain the same
    var isPlayer: Bool = false
    
    /// Entity that incapsulates physic behaviour of game object on the scene
    var physicsObject: PhysicsObject!
    /// Entity that incapsulates logic behavoiur of the object (various triggers)
    var aiObject: AIObject!
    
    weak var objectManager: GameObjectsManager?
    
    init(aPhysicsOnject: PhysicsObject,
         anAIObject: AIObject,
         anObjectManager: GameObjectsManager) {
        
        self.physicsObject = aPhysicsOnject
        self.aiObject      = anAIObject
        self.objectManager = anObjectManager
        
    }
        
    func moveLeft() {
        if self.aiObject.canMoveLeft() {
            self.physicsObject.moveLeft()
        }
    }
    
    func moveRight() {
        if self.aiObject.canMoveRight() {
            self.physicsObject.moveRight()
        }
    }
    
    func moveUp() {
        if self.aiObject.canMoveUp() {
            self.physicsObject.moveUp()
        }
    }
    
    func moveDown() {
        if self.aiObject.canMoveDown() {
            self.physicsObject.moveDown()
        }
    }
    
    func jump() {
        if self.aiObject.canJump() {
            self.physicsObject.jump()
        }
    }
    
    func rotate() {
        if self.aiObject.canRotate() {
            self.physicsObject.rotate()
        }
    }
    
}
