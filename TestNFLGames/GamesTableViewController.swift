//
//  GamesTableViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/17/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import RealmSwift

class GamesTableViewController: UITableViewController {

    let teams = [["Browns","Steelers","Patriots"], ["Nick","Ty","Zelda"]]
    let records = [["7-4","5-6","4-8"], ["321", "310", "283"]]
    var games :Results<Game>!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let downloader = Downloader()
        games = downloader.downloadSchedule()
        
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 2
        }else {
            return games.count
        }
    }

    func attributedString (first : String, last : String, cell : Int ) -> NSMutableAttributedString {
        
        var attributedString = NSMutableAttributedString()

        if cell == 0 {
            attributedString = NSMutableAttributedString(string: "\(first) with a record of \(last) ")

        }else {
            attributedString = NSMutableAttributedString(string: "\(first) total of \(last) points ")
        }
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSRange(location:0,length:first.characters.count))
//    
        var start = 0
        if cell == 0 {
            start = first.characters.count + " with a record of ".characters.count
        }else {
            start = first.characters.count + " total of ".characters.count
        }
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSRange(location:start,length:last.characters.count))
        

        return attributedString
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TopCell", forIndexPath: indexPath) as! TopInfoCell
            
            cell.titleTop.text = "The"
            cell.titleMiddle.text = "Best"
            if indexPath.row == 0 {
                cell.titleBottom.text = "Teams"
            }else {
                cell.titleBottom.text = "Players"

            }
            
           
            cell.firstPlace.attributedText = attributedString(teams[indexPath.row][0], last: records[indexPath.row][0], cell: indexPath.row)
            cell.secondPlace.attributedText = attributedString(teams[indexPath.row][1], last: records[indexPath.row][1], cell: indexPath.row)
            cell.thirdPlace.attributedText = attributedString(teams[indexPath.row][2], last: records[indexPath.row][2], cell: indexPath.row)

            
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameTableViewCell
            
            let game = games[indexPath.row]
            let awayTeamName = game.homeTeam
            let homeTeamName = game.awayTeam
            
            
            cell.homeTeam.text = homeTeamName.uppercaseString
            cell.awayTeam.text = awayTeamName.uppercaseString
            cell.homeBadge.image = UIImage(named: awayTeamName)
            cell.awayBadge.image = UIImage(named: homeTeamName)
            cell.awayPayout.text = "\(Int(arc4random_uniform(30) + 1))"
            cell.homePayout.text = "\(Int(arc4random_uniform(30) + 1))"
            
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("sectionHeader") as! CustomHeaderCell
        
        switch (section) {
        case 0:
            headerCell.sectionHeaderLabel.text = "Stats";
        //return sectionHeaderView
        case 1:
            headerCell.sectionHeaderLabel.text = "Upcoming Games";
        //return sectionHeaderView
        case 2:
            headerCell.sectionHeaderLabel.text = "South America";
        //return sectionHeaderView
        default:
            headerCell.sectionHeaderLabel.text = "Other";
        }
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
}
