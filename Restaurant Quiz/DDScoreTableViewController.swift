//
//  DDScoreTableViewController.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/20/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class DDScoreTableViewController: UITableViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Recent Scores"
        self.navigationController?.delegate = self
        tableView.rowHeight = 44
        
    }
    
    // MARK: - Table view data source

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
