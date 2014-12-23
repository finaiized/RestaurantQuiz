//
//  DDCityViewController.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/17/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class DDCityPickerController: UITableViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DDCity.allValues.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell
       
        cell.textLabel?.text = DDCity.allValues[indexPath.row].rawValue
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cpc = segue.destinationViewController as? DDCategoryPickerController {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let selectedCity = DDCity.allValues[indexPath!.row]
            cpc.city = selectedCity
        }
    }
    
}
