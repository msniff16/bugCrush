//
//  CombineViewController.swift
//  bugCrush
//
//  Created by Marlon Misra on 10/16/15.
//  Copyright © 2015 Marlon Misra. All rights reserved.
//

import UIKit

class CombineViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let vertTrans = (screenWidth / combineWidth) / 3
        
        //global variables to save location of combine after each loop
        var xLocation = CGFloat(30)
        var yLocation = CGFloat(30)
        
        let imageName = "combine.png"
        let image = UIImage(named: imageName)
        let combine = UIImageView(image: image!)
        combine.frame = CGRect(x: combineWidth, y: combineHeight, width: 60, height: 60)
        view.addSubview(combine)
        
        //get latest location of combine
        combine.center.x = xLocation
        combine.center.y = yLocation

    }
    
    var shouldMoveAgain = true
    var loopCount = 0

    
    @IBAction func moveCombine(sender: AnyObject) {
    
        animateCombine(loopCount)
    
    }
    
    func animateCombine(count: loopCount) {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.combine.center.y += CGFloat(vertTransDistance)
            print("move down")
        }) { (completed) -> Void in
            
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.combine.center.x += CGFloat(60)
            self.combine.transform = CGAffineTransformMakeRotation(CGFloat(-3 * M_PI))
            print("move over")
        }, completion: { (completed) -> Void in
            
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.combine.center.y -= CGFloat(vertTransDistance)
            print("move up")
        }, completion: { (completed) -> Void in
            
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.combine.center.x += CGFloat(60)
            self.combine.transform = CGAffineTransformMakeRotation(CGFloat(2 * M_PI))
            self.xLocation = self.combine.center.x
            self.yLocation = self.combine.center.y
            print("move over again")
            
            self.loopCount += 1
            
            if(self.loopCount < self.vertTrans) {
                self.animateCombine(self.loopCount)
            }
            
        })
        })
        })
        }
    
    }
    
}
