//
//  ArcanoidPE.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/19/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class ArcanoidPE: PhysicsEngine {

    var ballObject : Ball?
    
    override func update() {
        //override this method and handle base physics for your game world
        for gameObject in self.objectManager!.objects {
            gameObject.physicsObject.update()
            
            if let player = gameObject as? ArcPlayer {
               let rect = player.physicsObject.collisionRectagle
                if rect.origin.x < 0 {
                    player.physicsObject.position.x += 0 - rect.origin.x
                }
                
                if rect.origin.x + rect.size.width > self.bounds.size.width {
                    player.physicsObject.position.x += self.bounds.size.width - rect.origin.x - rect.size.width
                }

            }
            
            if let ball = gameObject as? Ball {
                self.handleBall(ball)
                
            }
                
            if let brick = gameObject as? Brick {
                self.handleBrick(brick)
            }
        }
        
    }
    
    func handleBall(ball: Ball) {
        self.ballObject = ball
        
        let rect = ball.physicsObject.collisionRectagle
        
        if rect.origin.x < 0 {
            ball.physicsObject.position.x += 0 - rect.origin.x
            ball.physicsObject.velocity.x *= -1
        }
        
        if rect.origin.x + rect.size.width > self.bounds.size.width {
            ball.physicsObject.position.x += self.bounds.size.width - rect.origin.x - rect.size.width
            ball.physicsObject.velocity.x *= -1
        }
        
        if rect.origin.y < 0 {
            ball.physicsObject.position.y += 0 - rect.origin.y
            ball.physicsObject.velocity.y *= -1
        }
        
        if rect.origin.y + rect.size.height > self.bounds.size.height {
            ball.physicsObject.position.y += self.bounds.size.height - rect.origin.y - rect.size.height
            ball.physicsObject.velocity.y *= -1
        }
        
        let playerRect = self.objectManager!.player!.physicsObject.collisionRectagle
        let top = playerRect.origin.y
        
        if rect.origin.y + rect.size.height > top {
            if (rect.origin.x + rect.size.width > playerRect.origin.x &&
                rect.origin.x  < playerRect.origin.x + playerRect.size.width)
            {
                ball.physicsObject.position.y += top - rect.origin.y - rect.size.height
                ball.physicsObject.velocity.y *= -1
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
            
            let ballRect = self.ballObject!.physicsObject.collisionRectagle
            let brickRect = brick.physicsObject.collisionRectagle
            
            if (ballRect.origin.x + ballRect.size.width >= brickRect.origin.x &&
                ballRect.origin.x <= brickRect.origin.x) {
                self.ballObject!.physicsObject.velocity.x *= -1
            }
            
            if (ballRect.origin.x <= brickRect.origin.x + brickRect.size.width &&
                ballRect.origin.x + ballRect.size.width >= brickRect.origin.x + brickRect.size.width) {
                self.ballObject!.physicsObject.velocity.x *= -1
            }
            
//            if (ballRect.origin.x > brickRect.origin.x  &&
//                ballRect.origin.x + ballRect.size.width < brickRect.origin.x + brickRect.size.width) {
//                self.ballObject!.physicsObject.velocity.y *= -1
//            }
            
            
            if (ballRect.origin.y + ballRect.size.height >= brickRect.origin.y &&
                ballRect.origin.y <= brickRect.origin.y) {
                self.ballObject!.physicsObject.velocity.y *= -1
            }
            
            if (ballRect.origin.y <= brickRect.origin.y + brickRect.size.height &&
                ballRect.origin.y + ballRect.size.height >= brickRect.origin.y + brickRect.size.height) {
                self.ballObject!.physicsObject.velocity.y *= -1
            }
            
//            if (ballRect.origin.y > brickRect.origin.y  &&
//                ballRect.origin.y + ballRect.size.height < brickRect.origin.y + brickRect.size.height) {
//                self.ballObject!.physicsObject.velocity.x *= -1
//            }

            
        }
    }
    
}


