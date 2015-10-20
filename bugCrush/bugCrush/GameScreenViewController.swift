//
//  GameScreenViewController.swift
//  bugCrush
//
//  Created by Matthew Sniff on 10/14/15.
//  Copyright © 2015 Marlon Misra. All rights reserved.
//

import UIKit

class GameScreenViewController: UIViewController {

    var farmerName: String?
    @IBOutlet weak var farmerChosen: UILabel!
    @IBOutlet weak var wallpaperView: UIView!
    @IBOutlet weak var target: UIImageView!
    var targetOrigin: CGPoint!
    
    var targetMoveAmount: CGFloat!
    
    
    
    // view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        //farmerChosen.text = farmerName
        
        targetOrigin = target.center
        targetMoveAmount = 40
       

    }
    
    override func viewWillAppear(animated: Bool) {
        
        var wallpaperWidth = wallpaperView.frame.size.width
        var wallpaperColumns = wallpaperWidth / 40
        
        var wallpaperHeight = wallpaperView.frame.size.height
        var wallpaperRows = wallpaperHeight / 40
        
        
        print("h:\(wallpaperView.bounds.size.height)")
        print("w:\(wallpaperView.frame.size.width)")
        print("w:\(wallpaperColumns)")
        print("w:\(wallpaperRows)")
        
        // draw corn onto screen
        for var i in 0...Int(wallpaperColumns + 2) {
            for var j in 0...Int(wallpaperRows + 2) {
                
                var cornImage = UIImage(named: "Corn3")
                var cornImageView = UIImageView(image: cornImage!)
                print("x: \(20+i*40), y: \(20+j*40)")
                cornImageView.center = CGPoint(x: 60+i*40, y: 60+j*40)
                cornImageView.frame.size = CGSize(width: 12.0, height: 12.0)
                wallpaperView.addSubview(cornImageView)
                
            }
        }
        
        for var i in 0...10 {
            print("bug created \(i)")
            var bugImage = UIImage(named: "pesticide2")
            var bugImageView = UIImageView(image: bugImage!)
            bugImageView.center = CGPoint(x: 60+i*40, y: 60+i*40)
            bugImageView.frame.size = CGSize(width: 40.0, height: 40.0)
            UIView.animateWithDuration(0, delay: 10, options: [], animations: { () -> Void in

                dispatch_async(dispatch_get_main_queue()) { // 2
                    self.wallpaperView.addSubview(bugImageView)
                }
                }, completion: { (completed) -> Void in
                    //nothing
            })
        }
        
    }
    
    // CREATE IMAGE IN CODE
    
//    var bugImage = UIImage(named: "pesticide2")
//    var bugImageView = UIImageView(image: bugImage!)
    
    
    
    
    
    // FIGURE OUT THE FRAME OF THE SCREEN TO SET LIMITS ON THE TARGET
    
    
    
    
    
    
    // MANAGEMENT OF THE ARROWS AND TARGET
    
    @IBAction func upArrow(sender: AnyObject) {
        print("up")
        //target.center = CGPoint(x: target.center.x, y: target.center.y - 20)
        target.center.y -= targetMoveAmount
    }

    @IBAction func rightArrow(sender: AnyObject) {
        print("right")
        target.center.x += targetMoveAmount
    }
    
    @IBAction func downArrow(sender: AnyObject) {
        target.center.y += targetMoveAmount
        print("down")
    }
    
    @IBAction func leftArrow(sender: AnyObject) {
        target.center.x -= targetMoveAmount
        print("left")
    }
    
    
    
    
    
    
    
    
    // MANAGEMENT OF BUG KILLING BUTTONS
    
    @IBAction func pestKill(sender: AnyObject) {
        print("pest")
    }
    
    
    @IBAction func herbKill(sender: AnyObject) {
        print("herb")        
    }
    
    
    @IBAction func roundup(sender: AnyObject) {
        print("roundup")
    }
    
    
    
}
