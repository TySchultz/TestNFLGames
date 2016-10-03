//
//  GamesTableViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/17/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import RealmSwift
import ASHorizontalScrollView
class MainViewTableViewController: UITableViewController {

    var currentGames : [[Game]]?
    var currentWeek = 0
    var gameFinder : GameFinder!
    var downloader : Downloader!
    
    var weekPicker : ASHorizontalScrollView!

    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameFinder = GameFinder()
        downloader = Downloader()
        
        currentWeek = 4 
        setupNavBar()
        setupWeekPicker()

        downloader.refreshSeasonData()
        loadGamesForWeek(week: currentWeek)
    }
    
    func loadGamesForWeek(week: Int) {
        currentGames = gameFinder.gamesForWeek(week: week)
        self.tableView.reloadData()
    }
    
    func refreshCurrentWeek(refreshControl : UIRefreshControl) {
        downloader.refreshCurrentWeek {
            self.loadGamesForWeek(week: self.currentWeek)
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        cell.setup(game: game, indexPath: indexPath,sectionCount: currentGames![indexPath.section].count - 1)

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
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshCurrentWeek(refreshControl:)), for: UIControlEvents.valueChanged)
    }
    
    func setupWeekPicker() {
        weekPicker = ASHorizontalScrollView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 50))
        weekPicker.leftMarginPx = 10
        weekPicker.miniMarginPxBetweenItems = 8
        weekPicker.miniAppearPxOfLastItem = 15
        weekPicker.uniformItemSize = CGSize(width: 45, height: 45)
        //This must be called after changing any size or margin property of this class to get acurrate margin
        weekPicker.setItemsMarginOnce()
        for index in 1...16{
            let week = UIButton(frame: CGRect.zero)
            week.layer.cornerRadius = 12
            week.layer.masksToBounds = true
            week.layer.borderColor = UIColor.black.cgColor
            week.layer.borderWidth = 1.0
            week.tag = index
            week.setTitle(String(index), for: UIControlState.normal)
            week.setTitleColor(UIColor.black, for: UIControlState.normal)
            if index == currentWeek {
                week.backgroundColor = UIColor.black
                week.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            week.addTarget(self, action: #selector(changeWeek(sender:)), for: UIControlEvents.touchUpInside)
            weekPicker.addItem(week)
        }
        self.headerView.addSubview(weekPicker)
    }
    
    
    func changeWeek(sender : UIButton) {
        for button in weekPicker.items as! [UIButton]{
            button.backgroundColor = UIColor.white
            button.setTitleColor(UIColor.black, for: UIControlState.normal)
        } 
        loadGamesForWeek(week: sender.tag)
        sender.backgroundColor = UIColor.black
        sender.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
}



