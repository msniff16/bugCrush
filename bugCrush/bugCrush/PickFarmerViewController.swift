//
//  PickFarmerViewController.swift
//  bugCrush
//
//  Created by Matthew Sniff on 10/14/15.
//  Copyright © 2015 Marlon Misra. All rights reserved.
//

import UIKit
import SwiftSpinner
// use spinner here: https://github.com/icanzilb/SwiftSpinner

class PickFarmerViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    // view loaded
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // set size of scroll view
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(320, contentView.frame.height)
        
        // back button in navbar
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
    }

    // go back to front page
    func back(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // chose dave
    @IBAction func onChoseDave(chooseButton: UIButton) {
        self.performSegueWithIdentifier("toGameScreen", sender: "Dave")
    }
    
    // chose marlon
    @IBAction func onChoseMarlon(chooseButton: UIButton) {
        self.performSegueWithIdentifier("toGameScreen", sender: "Marlon")
    }
    
    // send data over to gameScreen on segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let gameScreenVC = segue.destinationViewController as? GameScreenViewController {
            gameScreenVC.farmerName = sender as? String
        }
        
    }
    
}
