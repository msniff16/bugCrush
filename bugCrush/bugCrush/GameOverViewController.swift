//
//  GameOverViewController.swift
//  
//
//  Created by Marlon Misra on 10/27/15.
//
//

import UIKit

class GameOverViewController: UIViewController {
    
    
    //@IBOutlet weak var yield: UILabel!
    //@IBOutlet weak var bugsKilled: UILabel!
    
    var vertTransDistance: Int?
    var combine: UIImageView?
    var vertTrans: Int?
    var xLocation: CGFloat?
    var yLocation: CGFloat?
    var shouldMoveAgain = true
    var loopCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //yield.text = "Lalala"
        
        //get screen width and height
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = Int(screenSize.width)
        let screenHeight = Int(screenSize.height)
        
        //combine width and height
        let combineWidth = Int(60)
        let combineHeight = Int(60)
        
        //calculate vertical translation distance
        vertTransDistance = screenHeight - combineHeight
        
        //calculate number of animations in loops
        vertTrans = (screenWidth / combineWidth) / 2
        
        //global variables to save location of combine after each loop
        xLocation = CGFloat(0)
        yLocation = CGFloat(0)
        
        let image = UIImage(named: "combine.png")
        combine = UIImageView(image: image!)
        combine!.frame = CGRect(x: combineWidth, y: combineHeight, width: 60, height: 60)
        view.addSubview(combine!)
        
        //get latest location of combine
        combine!.frame.origin.x = xLocation!
        combine!.frame.origin.y = yLocation!
        
        animateCombine(loopCount)
    
    }
    
    
    
    func animateCombine(loopCount: Int) {
        
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            // animation
            }) { (completed) -> Void in
                // done
        }
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.combine!.frame.origin.y += CGFloat(self.vertTransDistance!)
            print("move down")
            }) { (completed) -> Void in
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.combine!.transform = CGAffineTransformMakeRotation(CGFloat(-3 * M_PI))
                    print("rotate")
                    }, completion: { (completed) -> Void in
                        
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.combine!.frame.origin.x += CGFloat(60)
                            print("move right")
                            }, completion: { (completed) -> Void in
                                
                                UIView.animateWithDuration(0.5, animations: { () -> Void in
                                    self.combine!.frame.origin.y -= CGFloat(self.vertTransDistance!)
                                    print("move up")
                                    }, completion: { (completed) -> Void in
                                        
                                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                                            self.combine!.transform = CGAffineTransformMakeRotation(CGFloat(2 * M_PI))
                                            print("rotate")
                                            }, completion: { (completed) -> Void in
                                                
                                                UIView.animateWithDuration(0.5, animations: { () -> Void in
                                                    self.combine!.frame.origin.x += CGFloat(60)
                                                    print("move right again")
                                                    }, completion: { (completed) -> Void in
                                                        
                                                        
                                                        //save locations
                                                        self.xLocation = self.combine!.frame.origin.x
                                                        self.yLocation = self.combine!.frame.origin.y
                                                        
                                                        self.loopCount += 1
                                                        
                                                        if(self.loopCount < self.vertTrans!) {
                                                            self.animateCombine(self.loopCount)
                                                        }
                                                        
                                                })
                                        })
                                })
                        })
                })
        }
        
    }
}
