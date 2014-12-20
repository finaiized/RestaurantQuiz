//
//  DDCategoryPickerController.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/19/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class DDCategoryPickerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var helpLabel: UILabel!
    
    var categories: [String] = [String]()
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Select Category"
        self.navigationController?.delegate = self
        
        if categories.count == 0 {
            pickerView.removeFromSuperview()
            helpLabel.text = "You must search first"
        }

    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categories[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if categories.count == 0 {
            return
        }
        
        if viewController is ViewController {
            let vc = viewController as ViewController
            vc.getRestaurantsInCategory(categories[selectedRow])
        }
    }

}
