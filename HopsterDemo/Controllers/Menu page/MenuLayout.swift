//
//  MenuLayout.swift
//  HopsterDemo
//
//  Created by Doronin Denis on 8/21/16.
//  Copyright © 2016 HP. All rights reserved.
//

import UIKit

protocol MenuLayoutDelegate {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    
}

class MenuLayout: UICollectionViewFlowLayout {

    var delegate: MenuLayoutDelegate!
    
    var numberOfRows = 2
    var cellPadding: CGFloat = 6.0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override func prepareLayout() {
        // 1
        if cache.isEmpty {

            for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                
                
                let size : CGSize = self.delegate.collectionView(collectionView!, layout: self, sizeForItemAtIndexPath: indexPath)
                
                var xPos = size.width * CGFloat(indexPath.row)
                var yPos = size.height * 0
                
                if (indexPath.row >= 4)
                {
                    xPos = size.width * CGFloat(indexPath.row-4)
                    yPos = size.height * 1
                }
                
                let frame = CGRect(x:xPos, y:yPos, width: size.width, height: size.height)
                let insetFrame = CGRectInset(frame, 0 , 0)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
            }
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    
}
