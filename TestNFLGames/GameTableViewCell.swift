//
//  GameTableViewCell.swift
//  TestNFLGames
//
//  Created by Nick Armold on 8/17/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import RealmSwift

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
    
    
    let PAYOUTSIZE_LARGE :CGFloat = 26
    let NAMESIZE_LARGE :CGFloat = 18

    let PAYOUTSIZE_NORMAL :CGFloat = 14
    let NAMESIZE_NORMAL :CGFloat = 14

    override func awakeFromNib() {
        super.awakeFromNib()
        homeBadge.layer.cornerRadius = 8.0
        awayBadge.layer.cornerRadius = 8.0
        
        homeBadge.layer.masksToBounds = true
        awayBadge.layer.masksToBounds = true
    }
    
    func mapGameToValues(game: Game){
        self.homeTeam.text = game.homeTeam.uppercased()
        self.awayTeam.text = game.awayTeam.uppercased()
        self.homeBadge.image = UIImage(named: game.homeTeam.teamMascotToCity())
        self.awayBadge.image = UIImage(named: game.awayTeam.teamMascotToCity())
        self.awayPayout.text = game.awayScore
        self.homePayout.text = game.homeScore
        self.time.text = game.gameTime
        self.id = game.id
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupVote(gameID : String) {
        
        DispatchQueue(label: "background").async {
            autoreleasepool {
                // Get realm and table instances for this thread
                let realme = try! Realm()
                
                var homeAlpha :CGFloat = 1.0
                var awayAlpha :CGFloat = 1.0
                if let vote = realme.object(ofType: Vote.self, forPrimaryKey: gameID + "Vote") {
                    switch vote.side {
                    case 1:
                        awayAlpha = 0.2
                        break
                    case 2:
                        homeAlpha = 0.2
                        break
                    default:
                        break
                    }
                }
                DispatchQueue.main.async {
                    self.homeBadge.alpha = homeAlpha
                    self.awayBadge.alpha = awayAlpha
                }
            }
        }

    }
    
    func updateFinishedGame (game: Game) {
        self.homePayout.font = fontForPayout(winner: false)
        self.awayPayout.font = fontForPayout(winner: false)
        self.homeTeam.font = fontForName(winner: false)
        self.awayTeam.font = fontForName(winner: false)
        switch game.quarter {
        case "F", "FO":
            self.time.text = "Final"

            if game.homeScore > game.awayScore{
                self.homePayout.font = fontForPayout(winner: true)
                self.awayPayout.font = fontForPayout(winner: false)
                
                self.homeTeam.font = fontForName(winner: true)
                self.awayTeam.font = fontForName(winner: false)

            }else{
                self.homePayout.font = fontForPayout(winner: false)
                self.awayPayout.font = fontForPayout(winner: true)
                
                self.homeTeam.font = fontForName(winner: false)
                self.awayTeam.font = fontForName(winner: true)
            }
            break
        default:
            self.time.text = game.gameTime
            self.homePayout.textColor = UIColor.black
            self.awayPayout.textColor = UIColor.black

        }
    }
    
    func fontForName(winner: Bool) -> UIFont {
        var size :CGFloat = NAMESIZE_NORMAL
        var weight : CGFloat = UIFontWeightLight
        if self.reuseIdentifier == "GameCell - Large" {
            size = NAMESIZE_LARGE
        }
        
        if winner {
            weight = UIFontWeightBlack
        }
        
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    func fontForPayout(winner: Bool) -> UIFont {
        var size :CGFloat = PAYOUTSIZE_NORMAL
        var weight : CGFloat = UIFontWeightMedium
        if self.reuseIdentifier == "GameCell-Large" {
            size = PAYOUTSIZE_LARGE
        }
        
        if winner {
            weight = UIFontWeightBlack
        }
        
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
   
}

extension UITableViewCell {
    func setupGradient(indexPath : IndexPath, sectionCount : Int  ){
        if indexPath.row == sectionCount {
            let lightGrayColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).cgColor
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = CGRect(x: 0, y: self.frame.height-100, width: self.frame.width, height: 100)
            gradient.colors = [UIColor.white.cgColor, lightGrayColor]
            gradient.name = "bottomGradient"
            self.layer.insertSublayer(gradient, at: 0)
            self.layer.masksToBounds = false
        }else{
            let layer = self.layer.sublayers?.first
            if layer?.name == "bottomGradient" {
                layer?.removeFromSuperlayer()
            }
        }
    }
}

extension String {
    func teamMascotToCity() -> String {
        
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
    
    func teamCityToMascot() -> String {
        
        switch self {
        case "Arizona":
            return "cardinals"
        case "Atlanta":
            return "falcons"
        case "Baltimore":
            return "ravens"
        case "Buffalo":
            return "bills"
        case "Carolina":
            return "panthers"
        case "Chicago":
            return "bears"
        case "Cincinatti":
            return "bengals"
        case "Cleveland":
            return "browns"
        case "Dallas":
            return "cowboys"
        case "Denver":
            return "broncos"
        case "Detroit":
            return "lions"
        case "GreenBay":
            return "packers"
        case "Houston":
            return "texans"
        case "Indianapolis":
            return "colts"
        case "Jacksonville":
            return "jaguars"
        case "KansasCity":
            return "chiefs"
        case "LosAngeles":
            return "rams"
        case "Miami":
            return "dolphins"
        case "Minnesota":
            return "vikings"
        case "NewEngland":
            return "patriots"
        case "NewOrleans":
            return "saints"
        case "NewYorkGiants":
            return "giants"
        case "NewYorkJets":
            return "jets"
        case "Oakland":
            return "raiders"
        case "Philadelphia":
            return "eagles"
        case "Pittsburg":
            return "steelers"
        case "SanDiego":
            return "chargers"
        case "SanFrancisco":
            return "49ers"
        case "Seattle":
            return "seahawks"
        case "TampaBay":
            return "buccaneers"
        case "Tennessee":
            return "titans"
        case "Washington":
            return "redskins"
        default:
            return ""
        }
    }

}
