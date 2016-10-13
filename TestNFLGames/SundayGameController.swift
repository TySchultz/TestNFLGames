//
//  SundayGameController.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class SundayGameController: IGListSectionController, IGListSectionType {
    
    var object: Game!
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 80)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: SundayGameCell.self, for: self, at: index) as! SundayGameCell
        cell.homeTeamImage.image = UIImage(named: object.homeTeam.teamMascotToCity())
        cell.awayTeamImage.image = UIImage(named: object.awayTeam.teamMascotToCity())
        cell.homeTeamName.text = object.homeTeam
        cell.awayTeamName.text = object.awayTeam
        cell.homeTeamScore.text = object.homeScore
        cell.awayTeamScore.text = object.awayScore
        cell.timeLabel.text = "Final"
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as! Game
    }
    
    func didSelectItem(at index: Int) {}
    
}
