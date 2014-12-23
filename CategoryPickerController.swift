//
//  CategoryPickerController.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/19/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class CategoryPickerController: UITableViewController {
    
    var city: City!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
    }
    
    @IBAction func done(sender: AnyObject) {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activity.startAnimating()
        let activityBarItem = UIBarButtonItem(customView: activity)
        navigationItem.rightBarButtonItem = activityBarItem
        
        var indexPath = tableView.indexPathForSelectedRow()
        if indexPath == nil {
            indexPath = NSIndexPath(forRow: 0, inSection: 0)
        }
        
        let category = Category.allValues[indexPath!.row]
        Yelp.restaurantsFromCity(city, category: category, completion: {
            [unowned self](restaurants: [Restaurant]) in
            let rand = Int(arc4random_uniform(UInt32(restaurants.count)))
            dispatch_async(dispatch_get_main_queue(), {
                let vc = self.navigationController?.viewControllers[0] as ViewController
                vc.startNewRound(restaurants[rand])
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
        })
    }
}

// MARK: - Table view data source
extension CategoryPickerController: UITableViewDataSource {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allValues.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = Category.allValues[indexPath.row].rawValue
        return cell
    }
}
