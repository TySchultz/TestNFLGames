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

    let teams = [["Nick","Ty","Zelda"],["Browns","Steelers","Patriots"]]
    let records = [["7-4","5-6","4-8"], ["321", "310", "283"]]
    let titles = ["TOP PLAYERS", "TOP TEAMS"]
    var games :Results<Game>!
    
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 93)
        self.navigationController?.navigationBarHidden = true

        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.12, green:0.71, blue:0.93, alpha:1.00)
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        

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
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }else if section == 1  {
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
            let cell = tableView.dequeueReusableCellWithIdentifier("YouCell", forIndexPath: indexPath) as! YouCell
            
            
            
            return cell
            
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TopCell", forIndexPath: indexPath) as! TopInfoCell
            
          
            
           
//            cell.firstPlace.attributedText = attributedString(teams[indexPath.row][0], last: records[indexPath.row][0], cell: indexPath.row)
//            cell.secondPlace.attributedText = attributedString(teams[indexPath.row][1], last: records[indexPath.row][1], cell: indexPath.row)
//            cell.thirdPlace.attributedText = attributedString(teams[indexPath.row][2], last: records[indexPath.row][2], cell: indexPath.row)
//            
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
        }else {
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        let destination = segue.destinationViewController as! GameViewTableViewController
        destination.title = "Browns vs. Steelers"
//        switch segue.identifier! {
//        case "BuildingDetail":
//           let detailController = segue.destinationViewController as! TableViewController
//        detailController.events = events[tableView.indexPathForSelectedRow!.row-1]
//        let headerText = buildings[tableView.indexPathForSelectedRow!.row-1]
//        detailController.title = headerText
//        if headerText == "Recreation and Physical Activity Center" {
//            detailController.title = "RPAC"
//        }
//        mixpanel.track(
//            "Building Selected",
//            properties: ["building name": buildings[tableView.indexPathForSelectedRow!.row-1]]
//        )
        

//        default:
//            print("this segue doesnt work")
//        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("sectionHeader") as! CustomHeaderCell
        
        switch (section) {
        case 0:
            headerCell.sectionHeaderLabel.text = "THIS IS YOU";
            headerCell.sectionHeaderLabel.textColor = UIColor(red:0.46, green:0.89, blue:0.56, alpha:1.00)
        //return sectionHeaderView
        case 1:
            headerCell.sectionHeaderLabel.text = "TODAY'S LEADERS";
            headerCell.sectionHeaderLabel.textColor = UIColor(red:0.95, green:0.51, blue:0.23, alpha:1.00)

        //return sectionHeaderView
        case 2:
            headerCell.sectionHeaderLabel.text = "UPCOMING GAMES";
            headerCell.sectionHeaderLabel.textColor = UIColor(red:0.22, green:0.64, blue:0.90, alpha:1.00)

        //return sectionHeaderView
        default:
            headerCell.sectionHeaderLabel.text = "Other";
        }
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset < 0 {
            self.headerTopConstraint.constant = offset + 24
        }
    }
}
