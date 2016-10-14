//
//  SettingsSectionController.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class SettingsSectionController: IGListSectionController, IGListSectionType {
    
    var object: Game?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 80)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: SettingsCell.self, for: self, at: index) as! SettingsCell
        cell.contentLabel.text = "Settings"
        cell.cellImage.image = #imageLiteral(resourceName: "Carolina")
        
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? Game
    }
    
    func didSelectItem(at index: Int) {}
    
}
