//
//  VideoController.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/21/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoController: UIViewController {

    var person: GamePerson?
    
    private var videoView: VideoView! { return self.view as! VideoView }
    private var alert:UIAlertController?
    private var playerController: AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.videoView.decorate()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playerDidFinishPlaying(_:)), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playerFailedToPlayToEndTime(_:)), name: AVPlayerItemFailedToPlayToEndTimeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playerStalled(_:)), name: AVPlayerItemPlaybackStalledNotification, object: nil)
        
        self.setupPlayer()
        
        // Do any additional setup after loading the view.
    }
    
    /// Create player, add observers for events
    
    func setupPlayer() {
        
        let videoURL = NSURL(string:(self.person?.streamingLink)!)
        let player = AVPlayer(URL: videoURL!)
        
        player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.New, context: nil)
        
        self.playerController = AVPlayerViewController()
        
        self.playerController!.player = player
        self.addChildViewController(self.playerController!)
        self.videoView.playerContainer.addSubview(self.playerController!.view)
        self.videoView.playerContainer.sendSubviewToBack(self.playerController!.view)
        
        self.playerController!.view.frame = self.videoView.playerContainer.bounds
        
        
        player.addPeriodicTimeObserverForInterval(CMTimeMakeWithSeconds(1.0 / 60.0, Int32(NSEC_PER_SEC)), queue: nil, usingBlock: { [weak self] time in
            guard let strongSelf = self else { return }
            strongSelf.updateProgressBar()
            
        })

        player.play()
        
    }
    
    /// notify user for the end of the movie
    func playerDidFinishPlaying(note: NSNotification) {
        let title = NSLocalizedString("Thanks!", comment: "")
        let message = NSLocalizedString("Video has finished, what is the next step?", comment: "")
        self.showAlert(title, message: message)
    }
    
    func playerFailedToPlayToEndTime(note: NSNotification) {
        let title = NSLocalizedString("Ooops!", comment: "")
        let message = NSLocalizedString("Some one prevented us to play video. What should we do?", comment: "")
        self.showAlert(title, message: message)
    }
    
    func playerStalled(note: NSNotification) {
        let title = NSLocalizedString("Ooops!", comment: "")
        let message = NSLocalizedString("Some one prevented us to play video. What should we do?", comment: "")
        self.showAlert(title, message: message)
    }
    
    
    /// observer for rate field - in order to handle play/pause event for updating ui
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard keyPath != nil else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            return
        }
        
        switch keyPath! {
        case "rate":
            if self.playerController?.player?.rate == 0.0 {
            self.videoView.setView(self.videoView.playerPause, hidden: false)
            }
            else {
                self.videoView.setView(self.videoView.playerPause, hidden: true)
            }
            break
        default:
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
        
    }
    
    /// progress bar update (since we have custom UI for our player
    func updateProgressBar() {
        let timeDuration = self.playerItemDuration()
        
        if timeDuration == kCMTimeInvalid {
            return
        }
        
        let duration = CMTimeGetSeconds(timeDuration);
        let time = CMTimeGetSeconds((self.playerController?.player?.currentTime())!);
        self.videoView!.playerProgress.progress = (Float) (time / duration);
    }
    
    func playerItemDuration() -> CMTime
    {
        if let thePlayerItem : AVPlayerItem = self.playerController?.player?.currentItem {
            if (thePlayerItem.status == AVPlayerItemStatus.ReadyToPlay) {
                return thePlayerItem.duration
            }
        }
        return kCMTimeInvalid
    }
    
    func showAlert(title: String, message: String) {
        let okTitle = NSLocalizedString("Let's watch again", comment: "")
        let cancelTitle = NSLocalizedString("No, return to the menu", comment: "")
        
        self.alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        self.alert!.addAction(UIAlertAction(title: okTitle, style: .Default, handler: {[weak self]  action in
            guard let strongSelf = self else { return }
            strongSelf.alert = nil
            strongSelf.playerController!.player!.seekToTime(kCMTimeZero)
            strongSelf.playerController!.player!.play()
            
        }))
        self.alert!.addAction(UIAlertAction(title: cancelTitle, style: .Cancel, handler: {[weak self]  action in
            
            guard let strongSelf = self else { return }
            strongSelf.alert = nil
            strongSelf.navigationController?.popToRootViewControllerAnimated(true)
        }))
        
        self.presentViewController(self.alert!, animated: true, completion: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        //remove observers
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.playerController?.player!.removeObserver(self, forKeyPath: "rate", context: nil)
        
    }
        
}
