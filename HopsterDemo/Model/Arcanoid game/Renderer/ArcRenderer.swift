//
//  ArcRenderer.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/19/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

class ArcRenderer: UIView,GameSceneRenderDelegate {

    weak var objectManager : GameObjectsManager?
    
    lazy var imgPlayer: UIImage = {
        var tmpPlayer: UIImage = UIImage(named: "arcPlayer")!
        return tmpPlayer
    }()

    
    lazy var imgBrick: UIImage = {
        var tmpBrick: UIImage = UIImage(named: "arcBrick")!
        return tmpBrick
    }()
    
    lazy var imgBallLeft: UIImage = {
        var imgBall: UIImage = UIImage(named: "arcBall")!
         imgBall = UIImage(CGImage: imgBall.CGImage!, scale: imgBall.scale, orientation: UIImageOrientation.UpMirrored)
        return imgBall
    }()
    
    lazy var imgBallRight: UIImage = {
        var imgBall: UIImage = UIImage(named: "arcBall")!
        
        return imgBall
    }()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        guard objectManager != nil else {
            return;
        }
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextClearRect(context, self.bounds);
        
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.blueColor().CGColor)
        
        
        
        for gameObject in objectManager!.objects {
            
            if let player = gameObject as? ArcPlayer {
                let rect = player.physicsObject.collisionRectagle
                self.imgPlayer.drawInRect(rect)
            }
            
            if let ball = gameObject as? Ball {
                CGContextSetStrokeColorWithColor(context,
                                                UIColor.redColor().CGColor)
                let rect = ball.physicsObject.collisionRectagle
                var imgBall : UIImage
                if (ball.physicsObject.velocity.x > 0) {
                    imgBall = self.imgBallRight
                }
                else {
                    imgBall = self.imgBallLeft
                }
                imgBall.drawInRect(rect)
            }
            
            if let brick = gameObject as? Brick {
                CGContextSetStrokeColorWithColor(context,
                                                 UIColor.blueColor().CGColor)
                let rect = brick.physicsObject.collisionRectagle
                self.imgBrick.drawInRect(rect)
            }
            
        }
        
        CGContextStrokePath(context)
    }
 
    func renderObjectFromManager(anObjectManager: GameObjectsManager) {
        
        self.objectManager = anObjectManager
        self.setNeedsDisplay()
        
    }
    
    func sceneBounds() -> CGRect {
        return self.bounds
    }
    
}
