//
//  PhysicsObject.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/19/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class PhysicsObject: NSObject {
    
    
    /// Since it's simple 2D game, positon is CGPoint
    ///
    /// position represent the center of object
    var position: CGPoint = CGPoint(x: 0, y: 0)
    
    /// Since it's simple 2D game, velocity is CGPoint
    var velocity: CGPoint = CGPoint(x: 0, y: 0)
    
    /// Since it's simple 2D game, acceleration is CGPoint
    var acceleration: CGPoint = CGPoint(x: 0, y: 0)
    
    /// for movement we should know angle (like in polar coordinate system)
    /// in order to build correct vector
    ///
    /// value is represented in radians
    var angle:  CGFloat = 0.0
    
    /// Size needed to calculate the whole rectangle that object holds on scene
    /// Rectangle will be used for collision detecting by PhysicsEngine
    ///
    /// Represents width/height of object in respect to the center (position)
    var size: CGSize = CGSize(width: 0, height: 0)
    
    /// Computed property which defines physical rectangle on game map
    ///
    /// Could be used for both PhysicsEngine and Render (which due to MVC model can be just UIView)
    var collisionRectagle: CGRect  {
        
        return CGRect(x: self.position.x - self.size.width / 2.0,
                      y: self.position.x - self.size.height / 2.0,
                      width: self.size.height,
                      height: self.size.width)
    }
    
    
    init(aPositon: CGPoint,
         anAngle:CGFloat,
         anVelocity:CGPoint,
         anAcceleration:CGPoint,
         aSize: CGSize)
    {
        
        self.position     = aPositon
        self.angle        = anAngle
        self.velocity     = anVelocity
        self.acceleration = anAcceleration
        self.size         = aSize
        
    }
    
    func update() {
        // update velocity by acceleration
        self.velocity.x += self.acceleration.x
        self.velocity.y += self.acceleration.y
        
        // change position due to velocity
        self.position.x += self.velocity.x
        self.position.y += self.velocity.y
        
    }
    
    // MARK: event handling
    func moveLeft() {
        // basic object is statis - it does not responde to events
    }
    
    func moveRight() {
        // basic object is statis - it does not responde to events
    }
    
    func moveUp() {
        // basic object is statis - it does not responde to events
    }
    
    func moveDown() {
        // basic object is statis - it does not responde to events
    }
    
    func jump() {
        // basic object is statis - it does not responde to events
    }
    
    func rotate() {
        // basic object is statis - it does not responde to events
    }

}
