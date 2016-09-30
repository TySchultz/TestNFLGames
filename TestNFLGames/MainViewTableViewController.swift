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

    var gameResults :Results<Game>?
    var currentGames : [[Game]]?
    var realm : Realm?
    
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        //Download season
//        let downloader = Downloader()
//        gameResults = downloader.downloadSchedule()

        realm = try! Realm()
        
        loadGamesForWeek(week: 4)
    }
    
    func loadGamesForWeek(week : Int) {
        gameResults = realm!.objects(Game.self).filter("gameWeek = \(week)").sorted(byProperty: "date", ascending: false)
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

        let destination : GameViewTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "GamesViewDetail") as! GameViewTableViewController
        self.navigationController?.pushViewController(destination, animated: true)
        
        let realm = try! Realm()
        destination.game = realm.object(ofType: Game.self, forPrimaryKey: currentCell.id)
        destination.setup() 
        destination.title = destination.game.homeTeam + " vs. " + destination.game.awayTeam
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
        
        var ID = "GameCell"
        if currentGames![indexPath.section].count == 1 {
            ID = "GameCell-Large"
        }
        
        let game = currentGames![indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! GameTableViewCell
        cell.mapGameToValues(game: currentGames![indexPath.section][indexPath.row])
        cell.setupGradient(indexPath: indexPath, sectionCount: currentGames![indexPath.section].count - 1)

        cell.setupVote(gameID: game.id)
        return cell
    }
}

//MARK: TableView Styling
extension MainViewTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "sectionHeader") as! CustomHeaderCell
        
        headerCell.sectionHeaderLabel.text = currentGames![section].first?.date
        return headerCell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.05
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if currentGames![indexPath.section].count == 1 {
            return 256
        }
        return 76
    }
    
    func setupNavBar () {
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 93)

        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
