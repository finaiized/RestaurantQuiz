//
//  ScoreTableViewCell.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/21/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var attemptsView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
