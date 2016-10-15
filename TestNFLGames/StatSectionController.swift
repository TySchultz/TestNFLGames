//
//  StatSectionController.swift
//  TestNFLGames
//
//  Created by Tyler J Schultz on 10/14/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class StatSectionController: IGListSectionController, IGListSectionType {
    
    var object: StatCell?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 40)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: DetailScreenStatCell.self, for: self, at: index) as! DetailScreenStatCell
       
        if let stats = object {
            cell.titleLabel.text = stats.title
            cell.homeStatLabel.text = "\(stats.homeStat)"
            cell.awayStatLabel.text = "\(stats.awayStat)"
            
            if let homeStat = object?.homeStat as? CGFloat, let awayStat = object?.awayStat as? CGFloat {
                cell.homeStatLabel.text = String(format: "%.0f", homeStat)
                cell.awayStatLabel.text = String(format: "%.0f", awayStat)

//                if (awayStat.isLess(than: homeStat)) {
//                    cell.homeStatLabel.font = Constants.mainInfoBold
//                    cell.awayStatLabel.font = Constants.mainInfoNormal
//                }else{
//                    cell.homeStatLabel.font = Constants.mainInfoNormal
//                    cell.awayStatLabel.font = Constants.mainInfoBold
//                }
            }
        }
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? StatCell
    }
    
    func didSelectItem(at index: Int) {}
    
}
