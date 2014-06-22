//
//  ViewController.swift
//  WaterflowSwift
//
//  Created by bhliu on 14-6-14.
//  Copyright (c) 2014 Katze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var i:Int = 33
        var j:CGFloat = 5.5
        var array:NSMutableArray = NSMutableArray()
        array.addObject(i)
        array.addObject(j)
        println(array)
        
        let m:CGFloat = array.lastObject as CGFloat
        println(m)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

