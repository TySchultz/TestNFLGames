//
//  PlayerCell.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/20/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var awayPlayers: UIStackView!
    @IBOutlet weak var homePlayers: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
