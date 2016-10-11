//
//  CustomHeaderCell.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/20/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {

    @IBOutlet weak var sectionHeaderLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(hideHeaderLabel), name: NSNotification.Name(rawValue: "hideSections"), object: nil )

        // Initializatison code
    }

    func hideHeaderLabel() {
        UIView.animate(withDuration: 0.2, animations: {
            self.sectionHeaderLabel.alpha = 0.0
            }) { (Bool) in
//                UIView.animate(withDuration: 3, delay: 5, options: [], animations: {
//                    self.sectionHeaderLabel.alpha = 1.0
//                    }, completion: nil)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
