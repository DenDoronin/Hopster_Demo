//
//  GameController.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    var gameView: GameView! { return self.view as! GameView }
    var gameScene: ArcanoidScene?
    
    private var actionSheet : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.gameView.decorate()
        self.gameScene = ArcanoidScene(aRenderer: self.gameView.arcRenderer!)
        self.setupEventHandlers()
        self.gameScene?.start()
        
    }
    
    func setupEventHandlers() {
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameController.swipeLeft(_:)))
        swipeLeft.direction = .Left
        self.gameView.arcRenderer!.addGestureRecognizer(swipeLeft)
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameController.swipeRight(_:)))
        swipeRight.direction = .Right
        self.gameView.arcRenderer!.addGestureRecognizer(swipeRight)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playerDidWin), name:arcanoidAEPlayerDidWin, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playerDidFail), name: arcanoidAEPlayerDidFail, object: nil)
    }
    
    func playerDidWin() {
        guard self.actionSheet == nil else {
            return;
        }
        
        self.gameScene?.stop()
        
        self.actionSheet = UIAlertController(title: "Great!", message: "You win, now you can enjoy video :)", preferredStyle: .ActionSheet)
        
        self.actionSheet!.addAction(UIAlertAction(title: "Yes, let's watch", style: .Default, handler: { action in
            self.actionSheet = nil
        }))
        
        self.actionSheet!.addAction(UIAlertAction(title: "No, return to the menu", style: .Default, handler: { action in
                    self.actionSheet = nil
                    self.navigationController?.popToRootViewControllerAnimated(true)
        }))
        self.presentViewController(self.actionSheet!, animated: true, completion: nil)
    }
    
    func playerDidFail() {
        
        guard self.actionSheet == nil else {
            return;
        }
        
        self.gameScene?.stop()
        
        self.actionSheet = UIAlertController(title: "Sorry :(", message: "Try again :)", preferredStyle: .ActionSheet)
        
        self.actionSheet!.addAction(UIAlertAction(title: "Yes, let's try", style: .Default, handler: { action in
            self.actionSheet = nil
            self.gameScene?.start()
        }))
        
        self.actionSheet!.addAction(UIAlertAction(title: "No, I want video!", style: .Default, handler: { action in
            self.actionSheet = nil
        }))
        
        self.actionSheet!.addAction(UIAlertAction(title: "No, return to the menu", style: .Default, handler: { action in
            self.actionSheet = nil
            self.navigationController?.popToRootViewControllerAnimated(true)
        }))
        self.presentViewController(self.actionSheet!, animated: true, completion: nil)

    }
    
    
    func swipeLeft(sender:UISwipeGestureRecognizer){
        NSLog("HP_Demo-[iOS] - swipe left")
        self.gameScene?.handleEvent(GameSceneEvents.GameSceneEventSwipeLeft)
    }
    
    func swipeRight(sender:UISwipeGestureRecognizer){
        NSLog("HP_Demo-[iOS] - swipe right")
        self.gameScene?.handleEvent(GameSceneEvents.GameSceneEventSwipeRight)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.gameScene?.stop()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
