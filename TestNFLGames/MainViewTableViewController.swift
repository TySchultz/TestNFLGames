//
//  GamesTableViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/17/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewTableViewController: UITableViewController {

    let teams = [["Nick","Ty","Zelda"],["Browns","Steelers","Patriots"]]
    let records = [["7-4","5-6","4-8"], ["321", "310", "283"]]
    let titles = ["TOP PLAYERS", "TOP TEAMS"]
    var games :Results<Game>!
    
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //the top view doesnt keep its height from the storyboard so we set it here
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 93)
        
        //We dont want the top bar on this screen only when we push to the detail screen
        self.navigationController?.navigationBarHidden = true

        
        //Back button setup
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        
        //Get games
        let downloader = Downloader()
        games = downloader.downloadSchedule()
        
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        let destination = segue.destinationViewController as! GameViewTableViewController
        destination.title = "Browns vs. Steelers"
    }
   
    //Keeps the header view stuck to the top when you pull down. 
    //A simple effect that looks kinda cool
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset < 0 {
            self.headerTopConstraint.constant = offset + 24
        }
    }
}

//MARK: Tableview Datasource

extension MainViewTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1  {
            return 2
        }else {
            return games.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
                return createYouCell(indexPath)
        case 1:
                return createTopCell(indexPath)
        case 2:
                return createGameCell(indexPath)
        default:
                return createGameCell(indexPath)
        }
    }
    
    
    func createYouCell(indexPath : NSIndexPath) -> YouCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("YouCell", forIndexPath: indexPath) as! YouCell
        
        return cell
    }
    
    
    func createTopCell(indexPath : NSIndexPath) -> TopInfoCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopCell", forIndexPath: indexPath) as! TopInfoCell
        
        cell.title.text = titles[indexPath.row]
        cell.firstPlace.text = teams[indexPath.row][0]
        cell.secondPlace.text = teams[indexPath.row][1]
        cell.thirdPlace.text = teams[indexPath.row][2]
        
        if indexPath.row == 0 {
            cell.leaderBoardButton.enabled = true
            cell.leaderBoardButton.alpha = 1.0
        }else {
            cell.leaderBoardButton.enabled = false
            cell.leaderBoardButton.alpha = 0.0
        }
        
        return cell
    }
    
    func createGameCell(indexPath : NSIndexPath) -> GameTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameTableViewCell
        
        let game = games[indexPath.row]
        let awayTeamName = game.homeTeam
        let homeTeamName = game.awayTeam
        var date = game.date
        var time = game.gameTime
        
        //Ty below is me trying to get date and shit.
        
        //Still need to do
        //Time right now is stuck on AM
        
        //Getting time to format example -> 04:25
        if ((time.characters.count) < 5) {
            print("IM HERE")
            time.insert("0", atIndex: time.startIndex.advancedBy(0))
        }
        
        
        //Trying to get date at format of example -> "2016-09-11"
        date.insert("-", atIndex: date.startIndex.advancedBy(4))
        date.insert("-", atIndex: date.startIndex.advancedBy(7))
        date.removeAtIndex(date.startIndex.advancedBy(11))
        date.removeAtIndex(date.startIndex.advancedBy(10))
        
        //Gets date and time in format below
        var dateAndTime = date.stringByAppendingString(" " + time)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        var kickoffTime = formatter.dateFromString(dateAndTime)
        
        var todaysDate:NSDate = NSDate()
        
        var kickoffInFuture = kickoffTime?.compare(todaysDate) == NSComparisonResult.OrderedDescending
        
        if (kickoffInFuture == false)
        {
            cell.lockImage.hidden = false
            cell.dateLabel.hidden = true
            cell.time.hidden = true
            
        }
        else {
            cell.lockImage.hidden = true
        }
        
        //This is where me trying ends
        
        cell.homeTeam.text = homeTeamName.uppercaseString
        cell.awayTeam.text = awayTeamName.uppercaseString
        cell.homeBadge.image = UIImage(named: awayTeamName)
        cell.awayBadge.image = UIImage(named: homeTeamName)
        cell.awayPayout.text = "\(Int(arc4random_uniform(30) + 1))"
        cell.homePayout.text = "\(Int(arc4random_uniform(30) + 1))"
        
        cell.dateLabel.text = date
        
        return cell
    }

}

//MARK: UI Styling

extension MainViewTableViewController {
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("sectionHeader") as! CustomHeaderCell
        
        switch (section) {
        case 0:
            headerCell.sectionHeaderLabel.text = "THIS IS YOU";
            headerCell.sectionHeaderLabel.textColor = UIColor(red:0.46, green:0.89, blue:0.56, alpha:1.00)
        case 1:
            headerCell.sectionHeaderLabel.text = "TODAY'S LEADERS";
            headerCell.sectionHeaderLabel.textColor = UIColor(red:0.95, green:0.51, blue:0.23, alpha:1.00)
        case 2:
            headerCell.sectionHeaderLabel.text = "UPCOMING GAMES";
            headerCell.sectionHeaderLabel.textColor = UIColor(red:0.22, green:0.64, blue:0.90, alpha:1.00)
        default:
            headerCell.sectionHeaderLabel.text = "Other";
        }
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70.0
        }else if indexPath.section == 1 {
            return 100.0
        }else {
            return 84.0
        }
    }
}
