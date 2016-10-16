//
//  TeamsListViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/16/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import RealmSwift
class TeamsListViewController: UIViewController, IGListAdapterDataSource, UIScrollViewDelegate {
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let gridItem = NSObject()
    
    var currentTeams : Results<Team>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.collectionView.contentInset = UIEdgeInsetsMake(0,0,44,0);
        
        let realm = try! Realm()
        currentTeams = realm.objects(Team)
            
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
        let it = currentTeams as! IGListDiffable
        let items: [IGListDiffable] = [it] as! [IGListDiffable]
        return items
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if let _ = object as? Team {
            return GridSectionController()
        }else {
            return GridSectionController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }

}
