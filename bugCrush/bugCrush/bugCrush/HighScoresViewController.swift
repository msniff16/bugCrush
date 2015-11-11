//
//  HighScoresViewController.swift
//  bugCrush
//
//  Created by Matthew Sniff on 10/15/15.
//  Copyright © 2015 Marlon Misra. All rights reserved.
//

import UIKit
import Firebase

class HighScoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    
    var highScores:[[String: AnyObject]] = []
    
    // Get a reference to our posts
    let baseref = Firebase(url:"https://bugcrush.firebaseio.com/scores")

    // view loaded]
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        // test data to save
        let newScore = [["name": "cameron", "score": 543]]
        baseref.setValue(newScore)
        
        let newScore2 = [["name": "matt", "score": 3400]]
        baseref.setValue(newScore2)
        
        // observe and pull changes in scores data
        baseref.observeEventType(.ChildAdded, withBlock: {
            snapshot in
            if let entry = snapshot.value as? [String: AnyObject] {
                self.highScores.append(entry)
                self.tableView.reloadData()
                print("\(snapshot.key) -> \(snapshot.value)")
            }
        })
    }
    
    // num rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    
    // fill data in for each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ScoreCell") as! ScoreCell
        var entry = highScores[indexPath.row]
        let playerName = entry["name"] as! String
        let score = entry["score"] as! Int
        cell.score.text = "\(playerName): \(score)"
        return cell
        
    }

}
