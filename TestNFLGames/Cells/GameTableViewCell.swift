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
    
    func setup(game: Game, indexPath: IndexPath, sectionCount: Int) {
        self.mapGameToValues(game: game)
        self.setupGradient(indexPath: indexPath, sectionCount: sectionCount)
        self.setupVote(gameID: game.id)
    }
    
    private func mapGameToValues(game: Game){
        self.homeTeam.text = game.homeTeam.uppercased()
        self.awayTeam.text = game.awayTeam.uppercased()
        self.homeBadge.image = UIImage(named: game.homeTeam.teamMascotToCity())
        self.awayBadge.image = UIImage(named: game.awayTeam.teamMascotToCity())
        self.awayPayout.text = game.awayScore
        self.homePayout.text = game.homeScore
        
        switch game.quarter {
        case "F", "FO":
            self.time.text = "Final"
        case "P":
            self.time.text = game.gameStart
            self.homePayout.text = ""
            self.awayPayout.text = ""
        case "H":
            self.time.text = "Half"
        case "1":
            self.time.text = "1st " + game.gameClock
        case "2":
            self.time.text = "2nd " + game.gameClock
        case "3":
            self.time.text = "3rd " + game.gameClock
        case "4":
            self.time.text = "4th " + game.gameClock
        default:
            self.time.text = game.gameStart
        }
        self.id = game.id
        
        self.homePayout.font = fontForPayout(winner: false)
        self.awayPayout.font = fontForPayout(winner: false)
        self.homeTeam.font = fontForName(winner: false)
        self.awayTeam.font = fontForName(winner: false)
        switch game.quarter {
        case "F", "FO":
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
            self.homePayout.textColor = UIColor.black
            self.awayPayout.textColor = UIColor.black
        }
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


