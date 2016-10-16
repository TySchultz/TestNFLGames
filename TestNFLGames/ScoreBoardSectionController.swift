//
//  ScoreBoardSectionController.swift
//  Sports
//
//  Created by Ty Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class ScoreBoardSectionController: IGListSectionController, IGListSectionType {
    
    var object: Game?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 45)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: ScoreBoardCell.self, for: self, at: index) as! ScoreBoardCell
        cell.placeLabel.text = String(index)
        cell.nameLabel.text = "Tyler"
        cell.scoreLabel.text = "342"
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? Game
    }
    
    func didSelectItem(at index: Int) {}
}
