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
     var id : String = ""


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: -5))
//        path.addLine(to: CGPoint(x: 70, y: -5))
//        path.addLine(to: CGPoint(x: 70, y: 90))
//        path.addLine(to: CGPoint(x: -5, y: 90))
//        path.addLine(to: CGPoint(x:0, y: 0))
//        
//        
//        let mask = CAShapeLayer()
//        mask.frame = awayBadge.frame
//        mask.path = path.cgPath
//        
//        awayBadge.layer.mask = mask
//        
//        
//        let seperator = UIBezierPath()
//        seperator.move(to: CGPoint(x: 10, y: 0))
//        seperator.addLine(to: CGPoint(x: 10, y: 90))
//        
//        let line = CAShapeLayer()
//        line.frame = awayBadge.frame
//        line.path = seperator.cgPath
//        line.strokeColor = UIColor.black.cgColor
//        line.lineWidth = 8.0
//        
//        
//        homeBadge.layer.addSublayer(line)
        
        homeBadge.layer.cornerRadius = 8.0
        awayBadge.layer.cornerRadius = 8.0
        
        homeBadge.layer.masksToBounds = true
        awayBadge.layer.masksToBounds = true
        
    

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}



extension String {
    func teamImage() -> String {
        
        switch self {
        case "cardinals":
            return "Arizona"
        case "falcons":
            return "Atlanta"
        case "ravens":
            return "Baltimore"
        case "bills":
            return "Buffalo"
        case "panthers":
            return "Carolina"
        case "bears":
            return "Chicago"
        case "bengals":
            return "Cincinatti"
        case "browns":
            return "Cleveland"
        case "cowboys":
            return "Dallas"
        case "broncos":
            return "Denver"
        case "lions":
            return "Detroit"
        case "packers":
            return "GreenBay"
        case "texans":
            return "Houston"
        case "colts":
            return "Indianapolis"
        case "jaguars":
            return "Jacksonville"
        case "chiefs":
            return "KansasCity"
        case "rams":
            return "LosAngeles"
        case "dolphins":
            return "Miami"
        case "vikings":
            return "Minnesota"
        case "patriots":
            return "NewEngland"
        case "saints":
            return "NewOrleans"
        case "giants":
            return "NewYorkGiants"
        case "jets":
            return "NewYorkJets"
        case "raiders":
            return "Oakland"
        case "eagles":
            return "Philadelphia"
        case "steelers":
            return "Pittsburg"
        case "chargers":
            return "SanDiego"
        case "49ers":
            return "SanFrancisco"
        case "seahawks":
            return "Seattle"
        case "buccaneers":
            return "TampaBay"
        case "titans":
            return "Tennessee"
        case "redskins":
            return "Washington"
        default:
            return ""
        }
    }

}
