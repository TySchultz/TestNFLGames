//
//  GameViewTableViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/20/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class GameViewTableViewController: UITableViewController {

    var homeTeamName : String = ""
    var awayTeamName : String = ""

    var time : String = ""
    
    var homeTeamBadge : UIImage?
    var awayTeamBadge : UIImage?
    
    var game : Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show the top bar
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setup() {
        if game != nil {
            self.homeTeamName = game.homeTeam
            self.awayTeamName = game.awayTeam
            self.homeTeamBadge =  UIImage(named: homeTeamName)
            self.awayTeamBadge = UIImage(named: awayTeamName)
            self.time = game.gameTime
            
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
}

// MARK: - Table view data source

extension GameViewTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath as NSIndexPath).section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! GameViewMainCell
            
            cell.awayTeamName.text = awayTeamName.capitalized
            cell.homeTeamName.text = homeTeamName.capitalized
            cell.timeLabel.text = time
            cell.homeTeamImage.image = homeTeamBadge
            cell.awayTeamImage.image = awayTeamBadge
            
            return cell
            
        }else if (indexPath as NSIndexPath).section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PayoutCell", for: indexPath) as! PayoutCell
            
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
            
            //Fake data for players who voted
            cell.homePlayers.addArrangedSubview(createView("Ty"))
            cell.homePlayers.addArrangedSubview(createView("Zelda"))
            cell.homePlayers.addArrangedSubview(createView("Sam"))
            cell.homePlayers.addArrangedSubview(createView("Jim"))
            cell.homePlayers.addArrangedSubview(createView("Ty"))
            
            cell.awayPlayers.addArrangedSubview(createView("Nick"))
            cell.awayPlayers.addArrangedSubview(createView("Katie"))
            cell.awayPlayers.addArrangedSubview(createView("JT"))
            cell.awayPlayers.addArrangedSubview(createView("Billy"))
            cell.awayPlayers.addArrangedSubview(createView("Matt"))
            cell.awayPlayers.addArrangedSubview(createView("Jeff"))
            cell.awayPlayers.addArrangedSubview(createView("Johnny"))
            
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
            headerCell.sectionHeaderLabel.text = "CHOOSE A TEAM";
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
        if (indexPath as NSIndexPath).section == 0 {
            return 130.0
        }else if (indexPath as NSIndexPath).section == 1 {
            return 130.0
        }else {
            return 240.0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
