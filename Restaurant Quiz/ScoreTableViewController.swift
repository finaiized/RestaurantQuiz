//
//  ScoreTableViewController.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/20/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        
        if tableView.numberOfRowsInSection(0) == 0 {
            let backgroundView = UIView(frame: tableView.frame)
            let label = UILabel(frame: CGRect(x: 10, y: 100, width: tableView.frame.width - 15, height: 20))
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.Center
            label.text = "Scores will show up here after you play"
            label.textColor = UIColor.lightGrayColor()
            backgroundView.addSubview(label)
            tableView.backgroundView = backgroundView
        }
    }
}

// MARK: - Table view data source
extension ScoreTableViewController: UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreTracker.sharedInstance.getScores().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScoreTableViewCell", forIndexPath: indexPath) as ScoreTableViewCell
        let score = ScoreTracker.sharedInstance.getScores()[indexPath.row]
        cell.scoreLabel.text = "\(score)"
        if score == ScoreTracker.sharedInstance.highestScore() {
            cell.scoreView.backgroundColor = UIColor.greenColor()
        }
        
        let attempts = ScoreTracker.sharedInstance.getAttempts()[indexPath.row]
        cell.attemptsLabel.text = "\(attempts)"
        if attempts == ScoreTracker.sharedInstance.minimumAttempts() {
            cell.attemptsView.backgroundColor = UIColor.greenColor()
        }
        
        return cell
    }
}
