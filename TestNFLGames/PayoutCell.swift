//
//  PayoutCell.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/21/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class PayoutCell: UITableViewCell {

    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var homeChoose: UIButton!
    @IBOutlet weak var awayChoose: UIButton!
    @IBOutlet weak var awayAmount: UILabel!
    @IBOutlet weak var homeAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
