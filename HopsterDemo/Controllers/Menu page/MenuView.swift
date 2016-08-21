//
//  MenuView.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class MenuView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
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


}
