//
//  MatchUpViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/4/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import RealmSwift
class MatchUpViewController: UIViewController, IGListAdapterDataSource, UIScrollViewDelegate {
    
    lazy var game : Game = Game()
    
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var sections : [Any] = []
    var loading = false
    let spinToken = NSObject()
    let gridItem = NSObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let voteBar = UIView(frame: CGRect(x: 0, y: self.view.frame.height-100, width: self.view.frame.width, height: 100 ))
        voteBar.backgroundColor = UIColor.white
        voteBar.layer.borderWidth = 1.0
//        voteBar.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view.snp.left)
//            make.right.equalTo(self.view.snp.right)
//            make.bottom.equalTo(self.view.snp.bottom)
//            make.height.equalTo(80)
//        }

        self.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        let realm = try! Realm()
        let homeTeam = realm.object(ofType: Team.self, forPrimaryKey: game.homeTeam)!
        let awayTeam = realm.object(ofType: Team.self, forPrimaryKey: game.awayTeam)!

        //Hack to make the team images appear lower
        sections.append(StatCell(title: "", homeStat: "", awayStat: ""))
        sections.append(StatCell(title: "", homeStat: "", awayStat: ""))
        sections.append(MatchupHeader(homeTeamName: game.homeTeam, awayTeamName: game.awayTeam))
        sections.append(StatCell(title: game.gameStart, homeStat: "", awayStat: ""))
        sections.append(game)
        sections.append(StatCell(title: "", homeStat: "", awayStat: ""))
        sections.append(StatCell(title: "Record", homeStat:  "3-4", awayStat:  "4-3"))
        sections.append(StatCell(title: "Plays Per Game", homeStat:  homeTeam.playsPerGame, awayStat:  awayTeam.playsPerGame))
        sections.append(StatCell(title: "Run %", homeStat:  (homeTeam.rushAttemptsPerGame/homeTeam.playsPerGame)*100, awayStat:  (awayTeam.rushAttemptsPerGame/homeTeam.playsPerGame)*100))
        sections.append(StatCell(title: "Pass %", homeStat:  (homeTeam.passAttemptsPerGame/homeTeam.playsPerGame)*100, awayStat:  (awayTeam.passAttemptsPerGame/homeTeam.playsPerGame)*100))

        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    //MARK: IGListAdapterDataSource
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var items: [IGListDiffable] = sections as! [IGListDiffable]
        return items
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        
        if let _ = object as? MatchupHeader {
            return MatchupHeaderSectionController()
        }else if let _ = object as? StatCell{
            return StatSectionController()
        }else if let _ = object as? Game {
            return VoteSectionController()
        }else {
            return StatSectionController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
    
    
}
