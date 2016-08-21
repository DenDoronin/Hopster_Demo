//
//  MenuModel.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/18/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

protocol MenuModelDelegate: class  {
    
    func modelDidStartActivity(model: MenuModel)
    func modelDidFinishActivity(model: MenuModel)
    
}

class MenuModel: NSObject {

    weak var delegate: MenuModelDelegate?
    
    var objects: [GamePerson] = []
    
    var operationQueue: NSOperationQueue
    
    init(aDelegate: MenuModelDelegate) {
        
        self.delegate       = aDelegate
        self.operationQueue = NSOperationQueue()
        self.operationQueue.maxConcurrentOperationCount = 1
    }
    
    func startActivity() {
        NSOperationQueue.mainQueue().addOperationWithBlock {[weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.delegate?.modelDidStartActivity(strongSelf)
            
        }
    }
    
    func finishActivity() {
        
        NSOperationQueue.mainQueue().addOperationWithBlock {[weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.delegate?.modelDidFinishActivity(strongSelf)
            
        }
    }
    
    func populateModel() {
       
        self.startActivity()
        
        let fetchOp = self.fetchOperation("resources")
        let downloadOp = self.downloadAllOperationWithDependency(fetchOp)
        
        self.operationQueue.addOperation(fetchOp)
        self.operationQueue.addOperation(downloadOp)
        
       
    }
    
    func downloadContent() {
        
        let finishOp = self.notifyOperation()
        
        var operations: [NSOperation] = []
        
        operations.append(finishOp)
        
        for gamePerson in self.objects {
            let downloadOp = self.downloadImageOperation(gamePerson)
            finishOp.addDependency(downloadOp)
            operations.append(downloadOp)
            
        }
        
        self.operationQueue.addOperations(operations, waitUntilFinished: false)
        
    }
    
    func fetchOperation(plistName:String) -> NSOperation {
        let fetchOp :NSOperation = NSBlockOperation {[weak self] in
            
            guard let strongSelf = self else { return }
            
            var personsArray: NSArray?
            if let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist") {
                personsArray = NSArray(contentsOfFile: path)
            }
            if let persons = personsArray {
                // Use your dict here
                for persDict in persons {
                    let name = persDict["name"] as! String
                    let thumbURL = persDict["thumbnail"] as! String
                    let link = persDict["streaming"] as! String
                    
                    let person = GamePerson(aName: name, aThumURL: thumbURL, aLink: link)
                    strongSelf.objects.append(person)
                    
                }
            }
        }
        return fetchOp
    }
    
    func downloadAllOperationWithDependency(op: NSOperation) -> NSOperation {
        let downloadOp :NSOperation = NSBlockOperation {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.downloadContent()
            
        }
        downloadOp.addDependency(op)
        return downloadOp
    }
    
    func downloadImageOperation(person:GamePerson) -> NSOperation {
        let downloadOp :NSOperation = NSBlockOperation {[weak person] in
            
            guard let strongPerson = person else { return }
            
            let imageURL  = NSURL(string: strongPerson.thumbnailURL)
            let imageData = NSData(contentsOfURL:imageURL!)
            

            if imageData?.length > 0 {
                let image = UIImage(data:imageData!)
                strongPerson.thumbnailImage = image!
            }
        }
        return downloadOp

    }
    
    func notifyOperation() -> NSOperation {
        let downloadOp :NSOperation = NSBlockOperation {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.finishActivity()
            
        }
        return downloadOp

    }
    
}
