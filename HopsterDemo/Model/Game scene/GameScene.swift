//
//  GameScene.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

enum GameSceneEvents {
    case GameSceneEventSingleTap
    case GameSceneEventDoubleTap
    case GameSceneEventSwipeLeft
    case GameSceneEventSwipeRight
    case GameSceneEventSwipeUp
    case GameSceneEventSwipeDown
}

class GameScene: NSObject {

    var physicsEngine: PhysicsEngine?
    var logicEngine  : AIEngine?
    var objectManager: GameObjectsManager?
    
    var gameSceneTimer: NSTimer!
    var gameSceneUpdateInerval: NSTimeInterval = 0.1  {
        // change interval on flight - just reinit timer with new value
       didSet {
        if self.gameSceneTimer != nil {
            self.gameSceneTimer.invalidate();
            self.gameSceneTimer = NSTimer.scheduledTimerWithTimeInterval(self.gameSceneUpdateInerval, target: self, selector: #selector(GameScene.update), userInfo: nil, repeats: true)
        }
        }
    }
    override init()
    {
        super.init()
        self.objectManager = GameObjectsManager()
        self.physicsEngine = PhysicsEngine(anObjectManager: self.objectManager!)
        self.logicEngine = AIEngine(anObjectManager: self.objectManager!)
        
        self.gameSceneTimer = NSTimer.scheduledTimerWithTimeInterval(self.gameSceneUpdateInerval, target: self, selector: #selector(GameScene.update), userInfo: nil, repeats: true)
    }
    
    func populateScene () {
        // TO DO create objects
        //
    }
    
    func start()
    {
        self.populateScene()
        self.gameSceneTimer.fire()
    }
    
    func update() {
        self.physicsEngine?.update()
        self.logicEngine?.update()
        // TO DO:: notify render
        
    }
    
    func handleEvent(event: GameSceneEvents)
    {
        switch event {
        case .GameSceneEventSingleTap:
            break
        case .GameSceneEventDoubleTap:
            break
        case .GameSceneEventSwipeLeft:
            break
        case .GameSceneEventSwipeRight:
            break
        case .GameSceneEventSwipeUp:
            break
        case .GameSceneEventSwipeDown:
            break
        }
    }
    
    func handleSingleTap() {
        
    }
    
    func handleDoubleTap() {
        
    }
    
    func handleSwipeLeft() {
        
    }
    
    func handleSwipeRight() {
        
    }
    
    func handleSwipeUp() {
        
    }
    
    func handleSwipeDown() {
        
    }
}
