//
//  MenuController.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnPlayDidPress()  {
        self.performSegueWithIdentifier("optionSelectedSegue", sender: self)
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
