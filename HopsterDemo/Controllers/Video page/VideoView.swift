//
//  VideoView.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/21/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class VideoView: UIView {

    @IBOutlet weak var playerContainer: UIView!
    @IBOutlet weak var playerProgress: UIProgressView!
    @IBOutlet weak var playerPause: UIImageView!

    func decorate () {
        self.backgroundColor = UIColor.redColor()
        
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "arcBackground")
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
        
        let views = ["imageView":imageView]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[imageView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[imageView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil, views: views))

    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transitionWithView(view, duration: 0.5, options: .TransitionCrossDissolve, animations: {() -> Void in
            view.hidden = hidden
            }, completion: { _ in })
    }
}
