//
//  SettingsViewController.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class SettingsViewController: UIViewController, IGListAdapterDataSource, UIScrollViewDelegate {
    
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
        
        sections.append(spinToken)
        for _ in 1...8 {
            sections.append("Settings")
        }

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
        if let _ = object as? String {
            return SettingsSectionController()
        }else {
            return PageHeaderController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
    
    
}
