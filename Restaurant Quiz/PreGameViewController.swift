//
//  PreGameViewController.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/22/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class PreGameViewController: UIViewController {
    var searchParams: (city: DDCity, category: DDCategory)!
    var chosenRestaurant: Restaurant?
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        descriptionLabel.text = "Finding \(searchParams.category.rawValue) restaurants in \(searchParams.city.rawValue)"
        Yelp.restaurantsFromCity(searchParams.city, category: searchParams.category, completion: {
            [unowned self] (data: NSData) in
            Restaurant.restaurantsFromYelpJSON(data, forCity: self.searchParams.city, completion: {
                [unowned self](restaurants: [Restaurant]) in
                let rand = Int(arc4random_uniform(UInt32(restaurants.count)))
                self.chosenRestaurant = restaurants[rand]
                dispatch_async(dispatch_get_main_queue(), {
                    self.startButton.enabled = true
                })
            })
        })
    }
    
    @IBAction func startGame(sender: AnyObject) {
        let vc = self.navigationController?.viewControllers[0] as ViewController
        vc.startNewRound(chosenRestaurant!)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
