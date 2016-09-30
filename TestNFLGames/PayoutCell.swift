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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func updateVote(homeChosen : Bool = false, awayChosen : Bool = false, isEnabled : Bool = true, homeAlpha : CGFloat = 1.0, awayAlpha : CGFloat = 1.0) {
        
        self.homeAmount.textColor = homeChosen ? UIColor.green : UIColor.black
        self.awayAmount.textColor = awayChosen ? UIColor.green : UIColor.black
        self.homeChoose.isEnabled = isEnabled
        self.awayChoose.isEnabled = isEnabled
        self.homeChoose.alpha = isEnabled ? 1.0 : 0.0
        self.awayChoose.alpha = isEnabled ? 1.0 : 0.0
        self.homeAmount.alpha = homeAlpha
        self.awayAmount.alpha = awayAlpha
    }
}
