//
//  ArcanoidScene.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/19/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class ArcanoidScene: GameScene {

    let bricksCount = 10
    
    override func setupScene() {
        // the starting point for custom components creation
        self.objectManager = ArcanoidOM()
        self.physicsEngine = ArcanoidPE(anObjectManager: self.objectManager!)
        self.logicEngine   = ArcanoidAE(anObjectManager: self.objectManager!)
    }
    
    override func populateScene() {
        // create scene
        
        self.createPlayer()
        self.createBall()
        self.createBricks()
    }
    
    func createPlayer() {
        let arcPlayerWidth  : CGFloat = 500.0
        let arcPlayerHeight : CGFloat = 100.0
        let arcPlayerPosition = CGPointMake(self.physicsEngine!.bounds.size.width / 2,
                                            self.physicsEngine!.bounds.size.height-arcPlayerHeight)
        
        let arcPlayerPO = ArcPlayerPO(aPositon: arcPlayerPosition,
                                      anAngle: 0.0,
                                      anVelocity: CGPointZero,
                                      anAcceleration: CGPointZero,
                                      aSize: CGSizeMake(arcPlayerWidth, arcPlayerHeight))
        
        let arcPlayerAI = ArcPlayerAI()
        let arcPlayer = ArcPlayer(aPhysicsOnject: arcPlayerPO,
                                  anAIObject: arcPlayerAI,
                                  anObjectManager: self.objectManager!)
        arcPlayer.isPlayer = true
        self.objectManager?.addObject(arcPlayer)
    }
    
    func createBall() {
        let ballWidth  : CGFloat = 70.0
        let ballHeight : CGFloat = 70.0
        let ballVelocity = CGPointMake(15.0, -15.0)
        let ballPosition = CGPointMake(self.physicsEngine!.bounds.size.width / 2 ,
                                            self.physicsEngine!.bounds.size.height - 1.5*ballHeight - self.objectManager!.player!.physicsObject!.size.height)
        
        let ballPO = BallPO(aPositon: ballPosition,
                          anAngle: 0.0,
                          anVelocity: ballVelocity,
                          anAcceleration: CGPointZero,
                          aSize: CGSizeMake(ballWidth, ballHeight))
        
        let ballAI = BallAI()
        let ball = Ball(aPhysicsOnject: ballPO,
                            anAIObject: ballAI,
                       anObjectManager: self.objectManager!)
        self.objectManager?.addObject(ball)
    }
    
    func createBricks() {
        
        let brickWidth  : CGFloat = 125.0
        let brickHeight : CGFloat = 125.0
        
        for i in 2...bricksCount-1 {
            
            let segmentWidth : CGFloat = self.physicsEngine!.bounds.size.width / CGFloat(bricksCount)
            let leftEdge : CGFloat = CGFloat(i-1) * segmentWidth + brickWidth/2
            let rightEdge : CGFloat = CGFloat(i) * segmentWidth - brickWidth/2
            
            let xPosition = CGFloat(arc4random_uniform(UInt32(rightEdge - leftEdge + 1))) + leftEdge
            let yPosition = CGFloat(arc4random_uniform(UInt32(300))) + 100
            
            
            let brickPosition = CGPointMake(xPosition,yPosition)
            
            let brickPO = PhysicsObject(aPositon: brickPosition,
                                anAngle: 0.0,
                                anVelocity: CGPointZero,
                                anAcceleration: CGPointZero,
                                aSize: CGSizeMake(brickWidth, brickHeight))
            
            let brickAI = AIObject()
            let brick = Brick(aPhysicsOnject: brickPO,
                              anAIObject: brickAI,
                              anObjectManager: self.objectManager!)
            self.objectManager?.addObject(brick)

        }
    }


}
