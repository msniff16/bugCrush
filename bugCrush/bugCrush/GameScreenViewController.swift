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
    
    @IBOutlet weak var target: UIImageView!
    var targetOrigin: CGPoint!
    
    var targetMoveAmount: CGFloat!
    
    
    
    // view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        farmerChosen.text = farmerName
        
        targetOrigin = target.center
        targetMoveAmount = 20

    }
    
    
    
    
    
    
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
    
    
    
    
    
    
    
    
    
    
    
}
