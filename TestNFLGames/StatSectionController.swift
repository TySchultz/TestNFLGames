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
        cell.titleLabel.text = object?.title
        cell.homeStatLabel.text = object?.homeStat
        cell.awayStatLabel.text = object?.awayStat

        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? StatCell
    }
    
    func didSelectItem(at index: Int) {}
    
}
