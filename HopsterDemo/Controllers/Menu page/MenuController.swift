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

    private var menuView: MenuView! { return self.view as! MenuView }
    private var menuModel: MenuModel!
    private var selectedPerson: GamePerson?
    
    private var alert:UIAlertController?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindView()
        self.showAlert()
        // Do any additional setup after loading the view.
    }

    func bindView() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.menuView.decorate()
        self.menuModel = MenuModel(aDelegate: self)
        self.menuModel.populateModel()
      //  self.menuView.btnPlay.addTarget(self, action: #selector(btnPlayDidPress), forControlEvents: UIControlEvents.PrimaryActionTriggered)
        
        self.menuView.collectionView.delegate = self
        self.menuView.collectionView.dataSource = self
        
        if let layout = self.menuView.collectionView.collectionViewLayout as? MenuLayout {
            layout.delegate = self
        }
    }
    
    func showAlert() {
        let title = NSLocalizedString("Welcome!", comment: "")
        let message = NSLocalizedString("Choose your character, tap and play! Video in the end will be your gift :)", comment: "")
        let okTitle = NSLocalizedString("Let's start", comment: "")
        
        self.alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        self.alert!.addAction(UIAlertAction(title: okTitle, style: .Default, handler: {action in
            }))

        self.presentViewController(self.alert!, animated: true, completion: nil)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        //restore button state
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "optionSelectedSegue") {
            let gameVC = segue.destinationViewController as! GameController
            gameVC.person = self.selectedPerson
            self.selectedPerson = nil
            
        }
    }

}

// MARK: - MenuModelDelegate
extension MenuController: MenuModelDelegate {
    // MenuModelDelegate methods
    func modelDidStartActivity(model: MenuModel) {
        print("started")
    }
    func modelDidFinishActivity(model: MenuModel) {
        print("finished")
        self.menuView!.collectionView.reloadData()
        
    }
}

extension MenuController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuModel.objects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("menuCellID", forIndexPath: indexPath) as? MenuCell {
            
            let person = self.menuModel.objects[indexPath.row]
            cell.configureCell(person)
            
            return cell
        }
        else {
            return MenuCell()
        }
    }
    
   
    
}

extension MenuController: UICollectionViewDelegate {

    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let previousItem = context.previouslyFocusedView as? MenuCell {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                previousItem.backgroundColor = UIColor.clearColor()
                previousItem.imgTopConstraint.constant = 200
            })
        }
        if let nextItem = context.nextFocusedView as? MenuCell {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                nextItem.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
                 nextItem.imgTopConstraint.constant = 25
            })
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let person = self.menuModel.objects[indexPath.row]
        self.selectedPerson = person
        self.performSegueWithIdentifier("optionSelectedSegue", sender: self)
    }
    
}

extension MenuController: MenuLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let cellWidth = self.menuView.frame.size.width / 4
        let cellHeight = self.menuView.frame.size.height / 2
        
        return CGSizeMake(cellWidth, cellHeight)
    }
}




