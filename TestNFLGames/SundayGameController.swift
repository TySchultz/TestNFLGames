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
        return CGSize(width: collectionContext!.containerSize.width, height: 90)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: SundayGameCell.self, for: self, at: index) as! SundayGameCell
        cell.homeTeamImage.image = UIImage(named: object.homeTeam.teamMascotToCity())
        cell.awayTeamImage.image = UIImage(named: object.awayTeam.teamMascotToCity())
        cell.homeTeamName.text = object.homeTeam.uppercased()
        cell.awayTeamName.text = object.awayTeam.uppercased()
        cell.homeTeamScore.text = object.homeScore
        cell.awayTeamScore.text = object.awayScore
        cell.timeLabel.text = object.gameStart
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as! Game
    }
    
    func didSelectItem(at index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) //if bundle is nil the main bundle will be used
        let matchUpView : MatchUpViewController = storyboard.instantiateViewController(withIdentifier: "matchUpView") as! MatchUpViewController
        matchUpView.game = object
        viewController?.navigationController?.pushViewController(matchUpView, animated: true)
    }
    
}
