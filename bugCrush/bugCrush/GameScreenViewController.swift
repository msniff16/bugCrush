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

    //Bomb counter = easy
    // Speeed bug creation - see timeInterval and divide by something each level
    //Count bugs killed and shots taken - then display on screen
    // Calculate 'bug seconds' and implied yield
    
    //OPTIONALS
    //
    
    var farmerName: String?
    var timeInterval: Double = 0.5
    var clock: Int = 0
    var alertShown = false
    var levelTime = 15
    var level = 0
    var cornSize = 5
    var cornCollection: [UIImageView] = []
    
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var farmerChosen: UILabel!
    @IBOutlet weak var wallpaperView: UIView!
    @IBOutlet weak var target: UIImageView!
    
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
        targetMoveAmount = 30
        self.clockLabel.text = "0"
        clockTimer()

        // turn auto-resize events into autolayout contraints
        self.target.translatesAutoresizingMaskIntoConstraints = true
        self.wallpaperView.translatesAutoresizingMaskIntoConstraints = true

        
    }
    
    // run clock
    func clockTimer() {
        
        // increment the clock
        let seconds = 1.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            // here code perfomed with delay
            self.clock += 1
            self.clockLabel.text = String(self.clock)
            
            // next level reached
            if((self.clock % self.levelTime) == 0) {
                
                // Get level
                self.level = (self.clock / self.levelTime) + 1
                
                if self.level == 11 {
                    self.performSegueWithIdentifier("highScore", sender: nil)
                    
                    //
                }
                
                // alert shown 
                self.alertShown = true
                
                // pop up
                let alert = UIAlertController(title: "Alert!", message: "Growth Stage: \(self.level)!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Oh snap!", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                    // restart bugs and timer
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(self.timeInterval, target: self, selector: "startGame", userInfo: nil, repeats: true)
                    self.clockTimer()
                    self.alertShown = false
                }))
                self.presentViewController(alert, animated: true, completion: nil)
                
                // stop the bugs
                self.timer.invalidate()
                
                //Grow the corn
                
                for (index,corn) in self.cornCollection.enumerate() {
                    corn.frame.size = CGSize(width: (self.cornSize * self.level), height: (self.cornSize * self.level))
                }
                
            } else {
                self.clockTimer()
            }
            
        })

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
                cornImageView.frame.size = CGSize(width: cornSize, height: cornSize)
                cornCollection.append(cornImageView)
                wallpaperView.addSubview(cornImageView)
                
            }
        }
        
        // call startGame() on a timer
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "startGame", userInfo: nil, repeats: true)
        
        wallpaperView.bringSubviewToFront(clockLabel)
        
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
        self.target.center.y -= targetMoveAmount
        if(self.target.center.y <= 0) {
            self.target.center.y = 0
        }
    }

    @IBAction func rightArrow(sender: AnyObject) {
        target.center.x += targetMoveAmount
        if(self.target.center.x >= self.view.bounds.size.width) {
            self.target.center.x = self.view.bounds.size.width
        }
    }
    
    @IBAction func downArrow(sender: AnyObject) {
        target.center.y += targetMoveAmount
        if(self.target.center.y >= self.view.bounds.size.height) {
            self.target.center.y = self.view.bounds.size.height
        }
    }
    
    @IBAction func leftArrow(sender: AnyObject) {
        target.center.x -= targetMoveAmount
        if(self.target.center.x <= 0) {
            self.target.center.x = 0
        }
    }

    // MANAGEMENT OF BUG KILLING BUTTONS
    
    @IBAction func pestKill(sender: AnyObject) {
        print("pest")
        nearBug()
        
        wallpaperView.backgroundColor = UIColor.redColor()
        UIView.animateWithDuration(0.2) { () -> Void in
            
            self.wallpaperView.backgroundColor = UIColor.whiteColor()
            
        }
        
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
        nukeBugs()
        
        wallpaperView.backgroundColor = UIColor.blackColor()
        UIView.animateWithDuration(2.0) { () -> Void in
            
            self.wallpaperView.backgroundColor = UIColor.whiteColor()
            
        }
        
        // play sound
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL (fileURLWithPath: NSBundle.mainBundle().pathForResource("atomicBomb", ofType: "mp3")!), fileTypeHint:nil)
            player.numberOfLoops = 1
            player.prepareToPlay()
            player.play()
        } catch {
            //Handle the error
            print("CANNOT PLAY!")
        }

    }
    
    
    var player : AVAudioPlayer! // will be Optional, must supply initializer

    
    // check if gun is close enough to bug to kill it
    func nearBug() {
        
        let currentPosition = target.center
        timer.invalidate()
        
        // loop thru all bugs
        for (index, i) in bugPositions.enumerate() {
            
            // bug is hit
            if( sqrt(square(Double(currentPosition.x) - Double(i.center.x))) + sqrt(square(Double(currentPosition.y) - Double(i.center.y))) < 65) {
                
                print("DESTROYED!")
                bugPositions = bugPositions.filter({$0 != i})
                i.removeFromSuperview()
                
                
            }
            
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "startGame", userInfo: nil, repeats: true)

        
    }
    
    func square(num: Double) -> Double {
        return num * num
    }
    
    // check if gun is close enough to bug to kill it
    func nukeBugs() {
        
        timer.invalidate()
        
        // loop thru all bugs
        for (index, i) in bugPositions.enumerate() {
            
            bugPositions = []
            i.removeFromSuperview()
            
        }
        
        // delay before sending more bugs onto screen after bomb
        let seconds = 3.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            if(!self.alertShown) {
                self.timer = NSTimer.scheduledTimerWithTimeInterval(self.timeInterval, target: self, selector: "startGame", userInfo: nil, repeats: true)
            }
            
        })
    
      
        

    }

    
    
}
