//
//  GameViewMainCell.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/20/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class GameViewMainCell: UITableViewCell {

    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
