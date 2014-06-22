//
//  WaterflowLayout.swift
//  WaterflowSwift
//
//  Created by bhliu on 14-6-14.
//  Copyright (c) 2014 Katze. All rights reserved.
//

import UIKit

protocol UICollecitonViewDelegateWaterFlowLayout: UICollectionViewDelegate {
    
    func flowLayout(flowView: WaterflowLayout, heightForRowAtIndex i:NSInteger) -> CGFloat
}

protocol UICollectionViewDataSourceWaterFlowLayout:UICollectionViewDataSource {
    func numberOfColumnsInFlowLayout(flowView: WaterflowLayout) -> NSInteger
}


class WaterflowLayout: UICollectionViewLayout {
    var numberOfColumns:NSInteger
    var currentPage:NSInteger
    
    var cellWidth:CGFloat
    var padding:CGFloat
    var contentHeight:CGFloat
    
    var cellCount:NSInteger
    var cellHeight :NSMutableArray = []
    var cellIndex :NSMutableArray = []
    var cellPosition: NSMutableArray = []
    
    
    var attributes: NSMutableArray = []
    var toDoItems: NSMutableArray = []
    
    var _flowdatasource: UICollectionViewDataSourceWaterFlowLayout?
    var _flowdelegate: UICollecitonViewDelegateWaterFlowLayout?
    
    init() {
        numberOfColumns = 0
        currentPage = 0
        cellWidth = 0.0
        padding = 0.0
        contentHeight = 0.0
        cellCount = 0
        padding = 5.0
        
        super.init()
    }
    
    override func prepareLayout() {
        self.attributes = NSMutableArray()
        cellCount = self.collectionView.numberOfItemsInSection(0)
        currentPage = 1
        
        contentHeight = self.initialize()
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath!) -> UICollectionViewLayoutAttributes!
    {
        var item: Int = indexPath.item
        return self.attributes[item] as UICollectionViewLayoutAttributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> AnyObject[]!{

        println(self.attributes)
        return self.attributes.filteredArrayUsingPredicate(NSPredicate(block:
            {(evaluatedObject, bindings) -> Bool in
                println((evaluatedObject as UICollectionViewLayoutAttributes).frame)
                return CGRectIntersectsRect(rect, (evaluatedObject as UICollectionViewLayoutAttributes).frame)
            }
            ))

    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(self.collectionView.frame.size.width, contentHeight)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return false
    }
    
    func initialize() -> (CGFloat) {
        
        println(self.attributes)
        
        numberOfColumns = _flowdatasource!.numberOfColumnsInFlowLayout(self)
        self.cellHeight = NSMutableArray()
        self.cellIndex = NSMutableArray()
        self.cellPosition = NSMutableArray()
        
        
        cellWidth =  (self.collectionView.frame.size.width - (numberOfColumns-1)*padding)/numberOfColumns

        var minHeight:CGFloat = 0.0
        var scrollHeight:CGFloat = 0.0
        var minHeightAtColumn:Int = 0
        
        for i in 0...cellCount-1 {
            //the first pics
            if self.cellHeight.count < numberOfColumns{

                self.cellHeight.addObject(NSMutableArray(object: Float( _flowdelegate!.flowLayout(self, heightForRowAtIndex: i))))
                self.cellIndex.addObject(NSMutableArray(object: i))
                
                minHeight = _flowdelegate!.flowLayout(self, heightForRowAtIndex: i)
                self.cellPosition.addObject(NSDictionary(objectsAndKeys: Int(minHeightAtColumn*(cellWidth+padding)),"x",Float(minHeight),"y"))
                minHeightAtColumn += 1
                
                let path:NSIndexPath = NSIndexPath(forItem: i, inSection: 0)
                let attribute: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: path)
                let x:Float = self.cellPosition.objectAtIndex(path.item).valueForKey("x").floatValue
                let y:Float = self.cellPosition.objectAtIndex(path.item).valueForKey("y").floatValue
                
                let height = _flowdelegate!.flowLayout(self, heightForRowAtIndex: path.item)
                attribute.size = CGSizeMake(cellWidth, height)
                attribute.center = CGPointMake(x + cellWidth/2, y - height/2)
                self.attributes.addObject(attribute)
                
                continue
            }
            
            for j in 0...numberOfColumns-1 {
                let cellHeightInPresentColumn:NSMutableArray = NSMutableArray(array: self.cellHeight[j] as NSMutableArray)
                if Double(floorf(cellHeightInPresentColumn.lastObject.floatValue)) <= Double(minHeight)
                {
                    minHeight = CGFloat(cellHeightInPresentColumn.lastObject.floatValue)
                    minHeightAtColumn = j
                }
                
            }
            
            minHeight += _flowdelegate!.flowLayout(self, heightForRowAtIndex: i)
            (self.cellHeight.objectAtIndex(minHeightAtColumn) as NSMutableArray).addObject(minHeight)
            (self.cellIndex.objectAtIndex(minHeightAtColumn) as NSMutableArray).addObject(i)
            self.cellPosition.addObject(NSDictionary(objectsAndKeys: (cellWidth+padding)*minHeightAtColumn,"x",minHeight,"y"))
            
            let path:NSIndexPath = NSIndexPath(forItem: i, inSection: 0)
            let attribute:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: path)
            let x:CGFloat = (self.cellPosition.objectAtIndex(path.item) as NSDictionary).objectForKey("x") as CGFloat
            let y:CGFloat = (self.cellPosition.objectAtIndex(path.item) as NSDictionary).objectForKey("y") as CGFloat
            let height:CGFloat = _flowdelegate!.flowLayout(self, heightForRowAtIndex: path.item)
            attribute.size = CGSizeMake(cellWidth, height)
            attribute.center = CGPointMake(x + cellWidth/2.0, y - height/2.0)
            self.attributes.addObject(attribute)

        }
        
        for j in 0...numberOfColumns-1 {
            if self.cellHeight.count < numberOfColumns || self.cellHeight.count == 0 {
                break
            }
            let columnHeight:CGFloat = self.cellHeight.objectAtIndex(j).lastObject as CGFloat
            scrollHeight = scrollHeight > columnHeight ? scrollHeight:columnHeight
        }
        
//        println(self.cellIndex)
//        println(self.cellPosition)
//        println(self.cellHeight)
//        println(self.attributes)
        
        return scrollHeight
    }
   
}
