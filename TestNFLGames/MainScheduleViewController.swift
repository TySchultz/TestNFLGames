/**
 Copyright (c) 2016-present, Facebook, Inc. All rights reserved.

 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit
import IGListKit

class Monday: NSObject {
    var homeTeam : String
    var awayTeam : String
    
    init(homeTeam : String, awayTeam : String){
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}

class MainScheduleViewController: UIViewController, IGListAdapterDataSource, UIScrollViewDelegate {

    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

    lazy var words : [Any] = []
    var loading = false
    let spinToken = NSObject()
    let gridItem = NSObject()
    
    
    
    var currentGames : [Any] = []
    var currentWeek = 0
    var gameFinder : GameFinder!
    var downloader : Downloader!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        words = []

        gameFinder = GameFinder()
        downloader = Downloader()
        
//        downloader.refreshSeasonData()
//        downloader.downloadTeams()
        currentWeek = 6
    
        currentGames.append(PageHeader(title: "Games"))
        
        loadGamesForWeek(week: currentWeek)
    
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        
        //        words.append(GridItem(color: UIColor(red: 237/255.0, green: 73/255.0, blue: 86/255.0, alpha: 1), itemCount: 16))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func loadGamesForWeek(week: Int) {
        currentGames.append(contentsOf: gameFinder.gamesForWeek(week: week))
    }
    
    func refreshCurrentWeek(refreshControl : UIRefreshControl) {
        downloader.refreshCurrentWeek {
            self.loadGamesForWeek(week: self.currentWeek)
        }
    }

    //MARK: IGListAdapterDataSource

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var items: [IGListDiffable] =  currentGames as! [IGListDiffable]
        if loading {
            items.append(spinToken)
        }
        return items
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        
        if let obj = object as? NSObject, obj === spinToken {
            return spinnerSectionController()
        }else if let _ = object as? PageHeader {
            return PageHeaderController()
        }else if let obj = object as? Game{
            if obj.thursdayGame {
                return MondayGameController()
            }else {
                return SundayGameController()
            }
        }else if let _ = object as? SectionHeader {
            return SectionHeaderController()
        }else {
            return SundayGameController()
        }
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }

//    //MARK: UIScrollViewDelegate
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
//        if !loading && distance < 200 {
//            loading = true
//            adapter.performUpdates(animated: true, completion: nil)
//            DispatchQueue.global(qos: .default).async(execute: {
//                // fake background loading task
//                sleep(2)
//                DispatchQueue.main.async {
//                    self.loading = false
//                    self.createData()
//                    self.adapter.performUpdates(animated: true, completion: nil)
//                }
//            })
//        }
//    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y > 50 {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        }else {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }

    
}
