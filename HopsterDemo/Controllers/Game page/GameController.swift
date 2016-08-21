//
//  GameController.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    var person: GamePerson?
    
    private var gameView: GameView! { return self.view as! GameView }
    private var gameScene: ArcanoidScene?

    private var actionSheet : UIAlertController?
    private var alert:UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.gameView.decorate()
        self.showAlert()
        
    }
    
    func showAlert() {
        let title = NSLocalizedString("Welcome", comment: "")
        let message = NSLocalizedString("Catch all bricks and watch video!", comment: "")
        let okTitle = NSLocalizedString("Let's start", comment: "")
        let cancelTitle = NSLocalizedString("No, I think next time", comment: "")
        
        self.alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        self.alert!.addAction(UIAlertAction(title: okTitle, style: .Default, handler: {[weak self]  action in
            guard let strongSelf = self else { return }
            strongSelf.alert = nil
            
            strongSelf.gameScene = ArcanoidScene(aRenderer: strongSelf.gameView.arcRenderer!)
            strongSelf.setupEventHandlers()
            strongSelf.gameScene?.start()
        }))
        self.alert!.addAction(UIAlertAction(title: cancelTitle, style: .Cancel, handler: {[weak self]  action in
            guard let strongSelf = self else { return }
            strongSelf.alert = nil
            strongSelf.navigationController?.popToRootViewControllerAnimated(true)
        }))
        
        self.presentViewController(self.alert!, animated: true, completion: nil)

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
        
        
        let title = NSLocalizedString("Great!", comment: "")
        let message = NSLocalizedString("You win, now you can enjoy video :)", comment: "")
        let okTitle = NSLocalizedString("Yes, let's watch", comment: "")
        let retryTitle = NSLocalizedString("No, I want one more try", comment: "")
        let cancelTitle = NSLocalizedString("No, return to the menu", comment: "")
        
        self.actionSheet = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        
        self.actionSheet!.addAction(UIAlertAction(title: okTitle, style: .Default, handler: {[weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.actionSheet = nil
            strongSelf.performSegueWithIdentifier("playVideoSegue", sender: self)
        }))
        
        self.actionSheet!.addAction(UIAlertAction(title: retryTitle, style: .Default, handler: {[weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.actionSheet = nil
            strongSelf.gameScene?.start()
        }))
        
        self.actionSheet!.addAction(UIAlertAction(title: cancelTitle, style: .Default, handler: {[weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.actionSheet = nil
            strongSelf.navigationController?.popToRootViewControllerAnimated(true)
        }))
        self.presentViewController(self.actionSheet!, animated: true, completion: nil)
    }
    
    func playerDidFail() {
        
        guard self.actionSheet == nil else {
            return;
        }
        
        self.gameScene?.stop()
        
        let title = NSLocalizedString("Sorry :(", comment: "")
        let message = NSLocalizedString("Try again :)", comment: "")
        let okTitle = NSLocalizedString("Yes, let's try", comment: "")
        let videoTitle = NSLocalizedString("No, I want video!", comment: "")
        let cancelTitle = NSLocalizedString("No, return to the menu", comment: "")
        
        self.actionSheet = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        
        self.actionSheet!.addAction(UIAlertAction(title: okTitle, style: .Default, handler: {[weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.actionSheet = nil
            strongSelf.gameScene?.start()
        }))
        
        self.actionSheet!.addAction(UIAlertAction(title: videoTitle, style: .Default, handler: {[weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.actionSheet = nil
            strongSelf.performSegueWithIdentifier("playVideoSegue", sender: self)
        }))
        
        self.actionSheet!.addAction(UIAlertAction(title: cancelTitle, style: .Default, handler: {[weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.actionSheet = nil
            strongSelf.navigationController?.popToRootViewControllerAnimated(true)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "playVideoSegue") {
            let videoVC = segue.destinationViewController as! VideoController
            videoVC.person = self.person
            
        }
    }

}
