//
//  GameViewTableViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/20/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import RealmSwift

class GameViewTableViewController: UITableViewController {

    var homeTeamName : String = ""
    var awayTeamName : String = ""

    var time : String = ""
    
    var homeTeamBadge : UIImage?
    var awayTeamBadge : UIImage?
    
    var game : Game!
    var vote : Vote?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Show the top bar
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isOpaque = true 
        setup()
    }
    
    func setup() {
        if game != nil {
            self.homeTeamName = game.homeTeam
            self.awayTeamName = game.awayTeam
            self.homeTeamBadge =  UIImage(named: homeTeamName.teamMascotToCity())
            self.awayTeamBadge = UIImage(named: awayTeamName.teamMascotToCity())
            self.time = game.gameTime
            self.tableView.reloadData()
            
            let realm = try! Realm()
            if let vote = realm.object(ofType: Vote.self, forPrimaryKey: game.id + "Vote") {
                self.vote = vote
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func voteOnGame(_ sender: UIButton) {
        
        let payoutCell = sender.superview?.superview?.superview?.superview as! PayoutCell
        
        let realm = try! Realm()
        
        let vote = Vote()
        vote.attachGame(game: self.game)
        vote.side = sender.tag
        vote.id = game.id + "Vote"
        
        try! realm.write {
            realm.add(vote, update: true)
        }
        var teamName = ""
        UIView.animate(withDuration: 0.1) {
            self.updateTopCel(voteSide: sender.tag)
            switch sender.tag {
            case 1:
                payoutCell.updateVote(homeChosen: true , isEnabled: true, homeAlpha: 1.0)
                teamName = self.homeTeamName
                break
            case 2:
                payoutCell.updateVote(awayChosen: true , isEnabled: true, awayAlpha: 1.0)
                teamName = self.awayTeamName
                break
            default:
                payoutCell.updateVote()
            }

        }
        
        let successView = Halo5Animation(frame: view.frame, name: teamName)
        view.addSubview(successView)
    }
    
    func updateTopCel(voteSide : Int ) {
        let topCell = self.tableView(self.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! GameViewMainCell

        if voteSide == 1 {
            topCell.homeTeamImage.alpha = 1.0
            topCell.awayTeamImage.alpha = 0.3
        }else{
            topCell.homeTeamImage.alpha = 0.3
            topCell.awayTeamImage.alpha = 1.0
        }
    }
}

// MARK: - Table view data source

extension GameViewTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! GameViewMainCell
            
            cell.awayTeamName.text = awayTeamName.capitalized
            cell.homeTeamName.text = homeTeamName.capitalized
            cell.timeLabel.text = time
            cell.homeTeamImage.image = homeTeamBadge
            cell.awayTeamImage.image = awayTeamBadge
            cell.setupGradient(indexPath: indexPath, sectionCount: 1)

            var homeAlpha :CGFloat = 1.0
            var awayAlpha :CGFloat = 1.0
            
            switch vote?.side {
            case 1?:
                awayAlpha = 0.3
                break
            case 2?:
                homeAlpha = 0.3
                break
            default:
                break
            }
            cell.homeTeamImage.alpha = homeAlpha
            cell.awayTeamImage.alpha = awayAlpha

            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PayoutCell", for: indexPath) as! PayoutCell
            
            if (vote != nil) {
                switch vote!.side {
                
                case 1:
                    cell.updateVote(homeChosen: true , isEnabled: true, homeAlpha: 1.0)
                    break
                case 2:
                    cell.updateVote(awayChosen: true , isEnabled: true, awayAlpha: 1.0)
                    break
                default:
                    cell.updateVote()
                }
            }
            cell.setupGradient(indexPath: indexPath, sectionCount: 1)

            return cell
        }
    }

    //Create a view for the player cell
    func createView (_ name : String) -> UILabel {
        let lab = UILabel()
        lab.text = name
        lab.font = UIFont(name: "System", size: 16.0)
        return lab
    }
}


//MARK: Header styling
extension GameViewTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "sectionHeader") as! CustomHeaderCell
        
        switch (section) {
        case 0:
            headerCell.sectionHeaderLabel.text = "";
            headerCell.sectionHeaderLabel.textColor = UIColor(red:0.46, green:0.89, blue:0.56, alpha:1.00)
        case 1:
            headerCell.sectionHeaderLabel.text = "WHO WILL WIN?";
            headerCell.sectionHeaderLabel.textColor = UIColor(red:0.95, green:0.51, blue:0.23, alpha:1.00)
        case 2:
            headerCell.sectionHeaderLabel.text = "PLAYERS";
            headerCell.sectionHeaderLabel.textColor = UIColor(red:0.22, green:0.64, blue:0.90, alpha:1.00)
        default:
            headerCell.sectionHeaderLabel.text = "Other";
        }
        
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }else{
            return 40.0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 260
        }else{
            return 160
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
