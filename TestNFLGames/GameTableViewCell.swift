//
//  GameTableViewCell.swift
//  TestNFLGames
//
//  Created by Nick Armold on 8/17/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var homeBadge: UIImageView!
    @IBOutlet weak var awayBadge: UIImageView!
    @IBOutlet weak var homePayout: UILabel!
    @IBOutlet weak var awayPayout: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lockImage: UIImageView!
    
    var game : Game!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
