//
//  MatchUpViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/4/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
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
        
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        sections.append(game)
        sections.append(StatCell(title: "Record", homeStat: "3-4", awayStat: "4-3"))
        sections.append(StatCell(title: "Record", homeStat: "3-4", awayStat: "4-3"))
        sections.append(StatCell(title: "Record", homeStat: "3-4", awayStat: "4-3"))
        sections.append(StatCell(title: "Record", homeStat: "3-4", awayStat: "4-3"))
        sections.append(StatCell(title: "Record", homeStat: "3-4", awayStat: "4-3"))

        
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
        if let _ = object as? Game {
            return MondayGameController()
        }else {
            return StatSectionController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
    
    
}
