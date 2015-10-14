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
    
    // view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        farmerChosen.text = farmerName

    }
}
