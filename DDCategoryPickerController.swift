//
//  DDCategoryPickerController.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/19/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class DDCategoryPickerController: UITableViewController {
    
    var city: DDCity!
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DDCategory.allValues.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = DDCategory.allValues[indexPath.row].rawValue
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let pgvc = segue.destinationViewController as? PreGameViewController {
            let indexPath = tableView.indexPathForSelectedRow()
            let category = DDCategory.allValues[indexPath!.row]
            pgvc.searchParams = (city: city, category: category)
        }
    }
}
