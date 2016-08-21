//
//  MenuCell.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/21/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var showImg: UIImageView!
    @IBOutlet weak var showLbl: UILabel!
    @IBOutlet weak var imgTopConstraint: NSLayoutConstraint!
    
    func configureCell(person: GamePerson) {
        
        showLbl.text = person.name
        
        
        self.showImg.layer.borderWidth = 10
        self.showImg.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        if person.thumbnailImage != nil {
            self.showImg.image = person.thumbnailImage
        }
    }

    
}
