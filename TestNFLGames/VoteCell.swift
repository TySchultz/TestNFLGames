//
//  VoteCell.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/15/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

class VoteSectionController: IGListSectionController, IGListSectionType {
    
    var object: Game?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 100)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: VoteCell.self, for: self, at: index) as! VoteCell
        cell.homeButton?.isEnabled = true
        cell.awayButton?.isEnabled = true
        cell.homeButton?.setTitle("Vote", for: UIControlState.normal)
        cell.awayButton?.setTitle("Vote", for: UIControlState.normal)
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? Game
    }
    
    func didSelectItem(at index: Int) {}
    
}


class VoteCell: UICollectionViewCell {
    
    func createLabel() ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = Constants.mainInfoBold
        return label
    }
    
    func createButton() ->  UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.width/2, height: self.frame.height))
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = Constants.mainInfoBold
        return button
    }
    
    // UI Objects
    var homeButton: UIButton?
    var awayButton: UIButton?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let homeButton = self.createButton()
        homeButton.titleLabel?.font = Constants.mainInfoBold
        self.contentView.addSubview(homeButton)
        
        let awayButton = self.createButton()
        awayButton.titleLabel?.font = Constants.mainInfoBold
        awayButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.contentView.addSubview(awayButton)

        
        homeButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX)
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        awayButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right)
            make.left.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
}
