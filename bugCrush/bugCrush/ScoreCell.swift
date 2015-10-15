//
//  ScoreCell.swift
//  bugCrush
//
//  Created by Matthew Sniff on 10/15/15.
//  Copyright © 2015 Marlon Misra. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
