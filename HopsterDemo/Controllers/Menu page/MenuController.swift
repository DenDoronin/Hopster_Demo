//
//  MenuController.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MenuController: UIViewController {

    var menuView: MenuView! { return self.view as! MenuView }
    var menuModel: MenuModel! = MenuModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindView()
        // Do any additional setup after loading the view.
    }

    func bindView() {
        self.menuView.btnPlay.addTarget(self, action: #selector(btnPlayDidPress), forControlEvents: UIControlEvents.PrimaryActionTriggered)
        
//        let videoURL = NSURL(string: "http://player.ooyala.com/player/all/gyMDk0cDr6snzZQW8Uz6vuF6wfHYi9eI.m3u8")
//        let player = AVPlayer(URL: videoURL!)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.bounds
//        self.view.layer.addSublayer(playerLayer)
//        player.play()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnPlayDidPress()  {
        // dismiss button in order to prevent double tap
        self.menuView.btnPlay.enabled = false
        self.performSegueWithIdentifier("optionSelectedSegue", sender: self)
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        //restore button state
        self.menuView.btnPlay.enabled = true
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
