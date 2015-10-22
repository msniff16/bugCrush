//
//  GameScreenViewController.swift
//  bugCrush
//
//  Created by Matthew Sniff on 10/14/15.
//  Copyright © 2015 Marlon Misra. All rights reserved.
//

import UIKit
import AVFoundation

class GameScreenViewController: UIViewController {

    var farmerName: String?
    @IBOutlet weak var farmerChosen: UILabel!
    @IBOutlet weak var wallpaperView: UIView!
    @IBOutlet weak var target: UIImageView! {
        
        didSet {
            print("TARGET SET: \(target.center)")
        }
        
    }

    // Create timer
    var timer = NSTimer()

    var targetOrigin: CGPoint!
    var bugPositions: [UIImageView] = []
    
    var targetMoveAmount: CGFloat!
    
    
    
    // view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        //farmerChosen.text = farmerName
        
        targetOrigin = target.center
        targetMoveAmount = 40

        // turn auto-resize events into autolayout contraints
        self.target.translatesAutoresizingMaskIntoConstraints = true
        self.wallpaperView.translatesAutoresizingMaskIntoConstraints = true


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
        
        // call startGame() on a timer
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startGame", userInfo: nil, repeats: true)
        
    }
    
    // game start
    func startGame() {
        
        // here code perfomed with delay
        let bugImage = UIImage(named: "pesticide2")
        let bugImageView = UIImageView(image: bugImage!)
        //bugImageView.center = CGPoint(x: 60+self.i*40, y: 60+self.i*40)
        let randomX: Int = Int(arc4random_uniform(800))
        let randomY: Int = Int(arc4random_uniform(800))
        print(random)
        bugImageView.center = CGPoint(x: 260+randomX, y:260+randomY)
        bugImageView.frame.size = CGSize(width: 40.0, height: 40.0)
        
        // add current bug's position to array
        self.bugPositions.append(bugImageView)
        
        self.wallpaperView.addSubview(bugImageView)
        
        print("\(target.center.x)")
        print("\(target.center.y)")
    }
    
    // MANAGEMENT OF THE ARROWS AND TARGET
    @IBAction func upArrow(sender: AnyObject) {
        print("up")
        //target.center = CGPoint(x: target.center.x, y: target.center.y - 20)
        self.target.center.y -= targetMoveAmount
        print("\(target.center.y)")
    }

    @IBAction func rightArrow(sender: AnyObject) {
        print("right")
        target.center.x += targetMoveAmount
        print("\(target.center.x)")
    }
    
    @IBAction func downArrow(sender: AnyObject) {
        target.center.y += targetMoveAmount
        print("down")
                print("\(target.center.y)")
    }
    
    @IBAction func leftArrow(sender: AnyObject) {
        target.center.x -= targetMoveAmount
        print("left")
        print("\(target.center.x)")
    }

    // MANAGEMENT OF BUG KILLING BUTTONS
    
    @IBAction func pestKill(sender: AnyObject) {
        print("pest")
        nearBug()
        
        
        // play sound
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL (fileURLWithPath: NSBundle.mainBundle().pathForResource("gunShot", ofType: "mp3")!), fileTypeHint:nil)
            player.numberOfLoops = 1
            player.prepareToPlay()
            player.play()
        } catch {
            //Handle the error
            print("CANNOT PLAY!")
        }
        
    }
    
    
    @IBAction func herbKill(sender: AnyObject) {
        print("herb")
    }
    
    
    @IBAction func roundup(sender: AnyObject) {
        print("roundup")
    }
    
    
    var player : AVAudioPlayer! // will be Optional, must supply initializer

    
    // check if gun is close enough to bug to kill it
    func nearBug() {
        
        let currentPosition = target.center
        
        // loop thru all bugs
        for (index, i) in bugPositions.enumerate() {
            
            // bug is hit
            if( sqrt(square(Double(currentPosition.x) - Double(i.center.x))) + sqrt(square(Double(currentPosition.y) - Double(i.center.y))) < 100) {
                
                print("DESTROYED!")
                i.removeFromSuperview()
                bugPositions.removeAtIndex(index)
                
                
            }
            
        }

        
    }
    
    func square(num: Double) -> Double {
        return num * num
    }
    
    
}
