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

    let teams = [["NICK","TY","ZELDA"],["BROWNS","STEELERS","PATRIOTS"]]
    let records = [["7-4","5-6","4-8"], ["321", "310", "283"]]
    let titles = ["TOP PLAYERS", "TOP TEAMS"]
    var games :Results<Game>!
    
    var homeBadgePassed:UIImage!
    var awayBadgePassed:UIImage!
    var homeTeamPassed:String!
    var awayTeamPassed:String!
    var timePassed:String!
    
    
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //the top view doesnt keep its height from the storyboard so we set it here
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 93)
        
        //We dont want the top bar on this screen only when we push to the detail screen
        self.navigationController?.isNavigationBarHidden = true

        
        //Back button setup
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed

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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! GameTableViewCell
        
        
        
        homeBadgePassed = currentCell.homeBadge.image
        awayBadgePassed = currentCell.awayBadge.image
        awayTeamPassed = currentCell.awayTeam.text
        print(currentCell.homeTeam.text! + " HERE")
        homeTeamPassed = currentCell.homeTeam.text
        timePassed = currentCell.time.text
        
        let destination : GameViewTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "GamesViewDetail") as! GameViewTableViewController
        self.navigationController?.pushViewController(destination, animated: true)
        
        destination.game = currentCell.game
        destination.setup() 
//        destination.homeTeamName = homeTeamPassed
//        destination.awayTeamName = awayTeamPassed
//        destination.time = timePassed
        destination.title = awayTeamPassed + " vs. " + homeTeamPassed
        
    
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let backItem = UIBarButtonItem()
//        backItem.title = ""
//        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
//        if (segue.identifier == "yourSegueIdentifer") {
//        let destination = segue.destinationViewController as! GameViewTableViewController
//        
//        print(homeTeamPassed)
//        
//            
//        }
    }
    

   
    //Keeps the header view stuck to the top when you pull down. 
    //A simple effect that looks kinda cool
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset < 0 {
            self.headerTopConstraint.constant = offset + 24
        }
    }
}

//MARK: Tableview Datasource

extension MainViewTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1  {
            return 2
        }else {
            return games.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath as NSIndexPath).section {
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
    
    
    func createYouCell(_ indexPath : IndexPath) -> YouCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YouCell", for: indexPath) as! YouCell
        
        return cell
    }
    
    
    func createTopCell(_ indexPath : IndexPath) -> TopInfoCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell", for: indexPath) as! TopInfoCell
        
        cell.title.text = titles[(indexPath as NSIndexPath).row]
        cell.firstPlace.text = teams[(indexPath as NSIndexPath).row][0]
        cell.secondPlace.text = teams[(indexPath as NSIndexPath).row][1]
        cell.thirdPlace.text = teams[(indexPath as NSIndexPath).row][2]
        
        if (indexPath as NSIndexPath).row == 0 {
            cell.leaderBoardButton.isEnabled = true
            cell.leaderBoardButton.alpha = 1.0
        }else {
            cell.leaderBoardButton.isEnabled = false
            cell.leaderBoardButton.alpha = 0.0
        }
        
        return cell
    }
    
    func createGameCell(_ indexPath : IndexPath) -> GameTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        
        let realm = try! Realm()
        
        let game = games[indexPath.row]
        let awayTeamName = game.awayTeam
        let homeTeamName = game.homeTeam
        var date = game.date
        var time = game.gameTime
        
        cell.game = game
        
        
//        let todaysDate:NSDate = NSDate()
//        
        let kickoffInFuture = true //kickoffTime?.compare(todaysDate) == NSComparisonResult.OrderedDescending
        
        if (kickoffInFuture == false)
        {
            cell.lockImage.isHidden = false
            cell.dateLabel.isHidden = true
            cell.time.isHidden = true
            
        }
        else {
            cell.lockImage.isHidden = true
        }
        
        //This is where me trying ends
        
        cell.homeTeam.text = homeTeamName.uppercased()
        cell.awayTeam.text = awayTeamName.uppercased()
        cell.homeBadge.image = UIImage(named: homeTeamName)
        cell.awayBadge.image = UIImage(named: awayTeamName)
        cell.awayPayout.text = "\(Int(arc4random_uniform(30) + 1))"
        cell.homePayout.text = "\(Int(arc4random_uniform(30) + 1))"
        cell.dateLabel.text = game.date
        cell.time.text = game.gameTime
        
        return cell
    }

}

//MARK: UI Styling

extension MainViewTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "sectionHeader") as! CustomHeaderCell
        
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).section == 0 {
            return 70.0
        }else if (indexPath as NSIndexPath).section == 1 {
            return 100.0
        }else {
            return 84.0
        }
    }
}
