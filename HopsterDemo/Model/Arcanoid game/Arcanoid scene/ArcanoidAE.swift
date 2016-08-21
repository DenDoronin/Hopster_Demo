//
//  ArcanoidAE.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/19/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

let arcanoidAEPlayerDidWin = "hp.hopsterdemo.arcanoidaeplayerdidwin"
let arcanoidAEPlayerDidFail = "hp.hopsterdemo.arcanoidaeplayerdidfail"

class ArcanoidAE: AIEngine {
    
    var ballObject : Ball?
    
    /////////////////////////////////////////////////////////////////////////////////////////
    //<----------------------------------------------------------------------------------->//
    // MARK: -                     Game scene main update method
    //<----------------------------------------------------------------------------------->//
    /////////////////////////////////////////////////////////////////////////////////////////
    
    override func update() {
        //override this method and handle base physics for your game world
        for gameObject in self.objectManager!.objects {
            gameObject.aiObject.update()
            
            if let ball = gameObject as? Ball {
                self.handleBall(ball)
                
            }
            
            if let brick = gameObject as? Brick {
                self.handleBrick(brick)
            }
        }
        
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////
    //<----------------------------------------------------------------------------------->//
    // MARK: -                     Game scene objects ai handle
    //<----------------------------------------------------------------------------------->//
    /////////////////////////////////////////////////////////////////////////////////////////
    
    func handleBall(ball: Ball) {
        self.ballObject = ball
        
        let rect = ball.physicsObject.collisionRectagle
        
        let playerRect = self.objectManager!.player!.physicsObject.collisionRectagle
        let top = playerRect.origin.y
        
        if rect.origin.y + rect.size.height > top {
            if (!(rect.origin.x + rect.size.width > playerRect.origin.x &&
                rect.origin.x  < playerRect.origin.x + playerRect.size.width))
            {
                //game ended
                NSNotificationCenter.defaultCenter().postNotificationName(arcanoidAEPlayerDidFail, object: self)
                
            }
            
        }
        
    }
    
    func handleBrick(brick: Brick)
    {
        
        let rBall = self.ballObject!.physicsObject.size.height
        let rBrick = brick.physicsObject.size.height
        
        let centerBall = self.ballObject!.physicsObject.position
        let centerBrick = brick.physicsObject.position
        let distanceToBall = pow( pow(centerBall.x-centerBrick.x,2.0) + pow(centerBall.y-centerBrick.y,2.0),0.5)
        
        if (distanceToBall < (rBall + rBrick) / 2){
            self.objectManager?.removeObject(brick)
            if (objectManager?.objects.count == 2)
            {
                // two objects mean player and ball, so we can finish game
                 NSNotificationCenter.defaultCenter().postNotificationName(arcanoidAEPlayerDidWin, object: self)
            }
        }
    }
}
