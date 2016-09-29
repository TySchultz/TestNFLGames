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
    var gameResults :Results<Game>?
    var currentGames : [[Game]]?
    
    var homeBadgePassed:UIImage!
    var awayBadgePassed:UIImage!
    var homeTeamPassed:String!
    var awayTeamPassed:String!
    var timePassed:String!
    
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 93)
        setupNavBar()
        
        //Download season
//        let downloader = Downloader()
//        games = downloader.downloadSchedule()
        
        let realm = try! Realm()
        gameResults = realm.objects(Game.self).filter("gameWeek = 3").sorted(byProperty: "date", ascending: false)
        findDates()
        self.tableView.reloadData()
    }
    
    func findDates() {
        var previousDate = ""
        var count = -1
        var filteredGames : [[Game]] = []
        for game in gameResults! {
            if game.date != previousDate {
                filteredGames.append([])
                previousDate = game.date
                count += 1
            }
            filteredGames[count].append(game)
            
        }
        currentGames = filteredGames
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
        let realm = try! Realm()
        destination.game = realm.object(ofType: Game.self, forPrimaryKey: currentCell.id)
        destination.setup() 
        destination.title = awayTeamPassed + " vs. " + homeTeamPassed
    }

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
        return currentGames!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentGames![section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return createGameCell(indexPath)
    }
    
    func createGameCell(_ indexPath : IndexPath) -> GameTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        
        let game = currentGames![indexPath.section][indexPath.row]
        
        cell.homeTeam.text = game.homeTeam.uppercased()
        cell.awayTeam.text = game.awayTeam.uppercased()
        cell.homeBadge.image = UIImage(named: game.homeTeam)
        cell.awayBadge.image = UIImage(named: game.awayTeam)
        cell.awayPayout.text = game.awayScore
        cell.homePayout.text = game.homeScore
        cell.time.text = game.gameTime
        cell.id = game.id
        
        return cell
    }

}

//MARK: UI Styling
extension MainViewTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "sectionHeader") as! CustomHeaderCell
        
        headerCell.sectionHeaderLabel.text = currentGames![section].first?.date
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 8, y: 0, width: self.view.frame.width-16, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: footerView.frame, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 8, height: 8)).cgPath
        footerView.layer.mask = maskLayer
        footerView.backgroundColor = UIColor.white
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
    }
    
    func setupNavBar () {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}




//Putting all this off until later!
//extension MainViewTableViewController {
//    func createYouCell(_ indexPath : IndexPath) -> YouCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "YouCell", for: indexPath) as! YouCell
//        
//        return cell
//    }
//    
//    
//    func createTopCell(_ indexPath : IndexPath) -> TopInfoCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell", for: indexPath) as! TopInfoCell
//        
//        cell.title.text = titles[(indexPath as NSIndexPath).row]
//        cell.firstPlace.text = teams[(indexPath as NSIndexPath).row][0]
//        cell.secondPlace.text = teams[(indexPath as NSIndexPath).row][1]
//        cell.thirdPlace.text = teams[(indexPath as NSIndexPath).row][2]
//        
//        if (indexPath as NSIndexPath).row == 0 {
//            cell.leaderBoardButton.isEnabled = true
//            cell.leaderBoardButton.alpha = 1.0
//        }else {
//            cell.leaderBoardButton.isEnabled = false
//            cell.leaderBoardButton.alpha = 0.0
//        }
//        
//        return cell
//    }
//    
//}
