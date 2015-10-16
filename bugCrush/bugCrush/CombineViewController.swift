//
//  CombineViewController.swift
//  bugCrush
//
//  Created by Marlon Misra on 10/16/15.
//  Copyright © 2015 Marlon Misra. All rights reserved.
//

import UIKit

class CombineViewController: UIViewController {
    
    
    @IBOutlet weak var combine: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
        
    @IBAction func moveCombine(sender: AnyObject) {

        //get screen width and height
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = Int(screenSize.width)
        let screenHeight = Int(screenSize.height)
        
        //combine width and height
        let combineWidth = Int(60)
        let combineHeight = Int(60)
        
        //calculate vertical translation distance
        let vertTransDistance = screenHeight - combineHeight
        
        //calculate number of animations in loops
        let vertTrans = (screenWidth / combineWidth) / 2
        
        //global variables to save location of combine after each loop
        var xLocation = CGFloat(30)
        var yLocation = CGFloat(30)
 
        
        //loop through number of vertical up/down translations
        //for i in 1...vertTrans {
        
            //get latest location of combine
            self.combine.center.x = xLocation
            self.combine.center.y = yLocation
        
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.combine.center.y += CGFloat(vertTransDistance)
                }) { (completed) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.combine.center.x += CGFloat(combineWidth)
                        self.combine.transform = CGAffineTransformMakeRotation(CGFloat(-1 * M_PI))
                        }, completion: { (completed) -> Void in
                            UIView.animateWithDuration(0.5, animations: { () -> Void in
                                self.combine.center.y -= CGFloat(vertTransDistance)
                                }, completion: { (completed) -> Void in
                                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                                        self.combine.center.x += CGFloat(combineWidth)
                                        self.combine.transform = CGAffineTransformMakeRotation(CGFloat(-1 * M_PI))
                                        xLocation = self.combine.center.x
                                        yLocation = self.combine.center.y
                                    })
                            })
                    })
            //}
        
        }
    }
}
