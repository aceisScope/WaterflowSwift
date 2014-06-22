//
//  WaterflowCollectionViewController.swift
//  WaterflowSwift
//
//  Created by bhliu on 14-6-22.
//  Copyright (c) 2014 Katze. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class WaterflowCollectionViewController: UICollectionViewController,UICollectionViewDataSource,UICollectionViewDelegate, UICollecitonViewDelegateWaterFlowLayout,UICollectionViewDataSourceWaterFlowLayout {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(collectionViewLayout layout: UICollectionViewLayout!)  {
        super.init(collectionViewLayout: layout)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.allowsSelection = true
        self.collectionView.frame = self.view.bounds
        self.collectionView.contentInset = UIEdgeInsetsZero

        // Register cell classes
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        (self.collectionView.collectionViewLayout as WaterflowLayout)._flowdelegate = self
        (self.collectionView.collectionViewLayout as WaterflowLayout)._flowdatasource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */

    // #pragma mark UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 20
    }

    override func collectionView(collectionView: UICollectionView?, cellForItemAtIndexPath indexPath: NSIndexPath?) -> UICollectionViewCell? {
        let cell = collectionView?.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
    
        // Configure the cell
        
        switch (indexPath!.item + indexPath!.section) % 5 {
        case 0:
            cell.backgroundColor = UIColor.blueColor()
            break
        case 1:
            cell.backgroundColor = UIColor.redColor()
            break
        case 2:
            cell.backgroundColor = UIColor.purpleColor()
            break
        case 3:
            cell.backgroundColor = UIColor.yellowColor()
            break
        case 4:
            cell.backgroundColor = UIColor.greenColor()
            break
        case 5:
            cell.backgroundColor = UIColor.blackColor()
            break
            
        default:
            break;
        }
        
        
    
        return cell
    }

    //pragma mark <UICollectionViewDelegate>

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(collectionView: UICollectionView?, shouldHighlightItemAtIndexPath indexPath: NSIndexPath?) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(collectionView: UICollectionView?, shouldSelectItemAtIndexPath indexPath: NSIndexPath?) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(collectionView: UICollectionView?, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath?) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView?, canPerformAction action: String?, forItemAtIndexPath indexPath: NSIndexPath?, withSender sender: AnyObject) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView?, performAction action: String?, forItemAtIndexPath indexPath: NSIndexPath?, withSender sender: AnyObject) {
    
    }
    */
    
    //pragma mark <UICollectionViewDataSourceWaterFlowLayout>
    func numberOfColumnsInFlowLayout(flowView: WaterflowLayout) -> NSInteger  {
        return 3
    }
    
    
    //pragma mark <UICollecitonViewDelegateWaterFlowLayout>
    func flowLayout(flowView: WaterflowLayout, heightForRowAtIndex i: NSInteger) -> CGFloat  {
        var height:CGFloat = 0
        switch i%5 {
        case 0:
            height = 127
            break
        case 1:
            height = 100
            break
        case 2:
            height = 87
            break
        case 3:
            height = 114
            break
        case 4:
            height = 140
            break
        case 5:
            height = 158
            break
        default:
            break
        }
        
        return height
    }
    

}
