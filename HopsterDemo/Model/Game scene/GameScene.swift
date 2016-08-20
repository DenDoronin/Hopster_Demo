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


protocol GameSceneRenderDelegate: class  {

    func renderObjectFromManager(anObjectManager: GameObjectsManager)
    func sceneBounds() -> CGRect
}



class GameScene: NSObject {

    var physicsEngine: PhysicsEngine?
    var logicEngine  : AIEngine?
    var objectManager: GameObjectsManager?
    weak var renderer: GameSceneRenderDelegate?
    
    var gameSceneTimer: NSTimer!
    var gameSceneUpdateInerval: NSTimeInterval = 0.05  {
        // change interval on flight - just reinit timer with new value
       didSet {
        if self.gameSceneTimer != nil {
            self.gameSceneTimer.invalidate();
            self.gameSceneTimer = NSTimer.scheduledTimerWithTimeInterval(self.gameSceneUpdateInerval, target: self, selector: #selector(GameScene.update), userInfo: nil, repeats: true)
        }
        }
    }
    init(aRenderer: GameSceneRenderDelegate)
    {
        
        super.init()
        self.renderer = aRenderer

       
    }
    func setupScene() {
        // the starting point for custom components creation
        self.objectManager = GameObjectsManager()
        self.physicsEngine = PhysicsEngine(anObjectManager: self.objectManager!)
        self.logicEngine   = AIEngine(anObjectManager: self.objectManager!)
    }
    
    func populateScene() {
        // TO DO create objects
        //
    }
    
    func start()
    {
        self.setupScene()
        self.physicsEngine?.bounds = (self.renderer?.sceneBounds())!
        self.populateScene()
        self.gameSceneTimer = NSTimer.scheduledTimerWithTimeInterval(self.gameSceneUpdateInerval,
                                                                     target: self,
                                                                     selector: #selector(update),
                                                                     userInfo: nil, repeats: true)
    }
    
    func stop()
    {
        self.gameSceneTimer.invalidate()
        self.gameSceneTimer = nil
    }
    
    func update() {
        self.physicsEngine?.update()
        self.logicEngine?.update()
        self.renderer?.renderObjectFromManager(self.objectManager!)
        
    }
    
    func handleEvent(event: GameSceneEvents)
    {
        switch event {
        case .GameSceneEventSingleTap:
            self.handleSingleTap()
            break
        case .GameSceneEventDoubleTap:
            self.handleDoubleTap()
            break
        case .GameSceneEventSwipeLeft:
            self.handleSwipeLeft()
            break
        case .GameSceneEventSwipeRight:
            self.handleSwipeRight()
            break
        case .GameSceneEventSwipeUp:
            self.handleSwipeUp()
            break
        case .GameSceneEventSwipeDown:
            self.handleSwipeDown()
            break
        }
    }
    
    func handleSingleTap() {
        self.objectManager?.player?.jump()
    }
    
    func handleDoubleTap() {
        
    }
    
    func handleSwipeLeft() {
        self.objectManager?.player?.moveLeft()
    }
    
    func handleSwipeRight() {
        self.objectManager?.player?.moveRight()
    }
    
    func handleSwipeUp() {
        self.objectManager?.player?.moveUp()
    }
    
    func handleSwipeDown() {
        self.objectManager?.player?.moveDown()
    }
}
