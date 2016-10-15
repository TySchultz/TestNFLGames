//
//  MatchupHeaderCell.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/15/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

class MatchupHeader: NSObject {
    
    let homeTeamName: String
    let awayTeamName: String
    
    init(homeTeamName : String, awayTeamName : String) {
        self.homeTeamName = homeTeamName
        self.awayTeamName = awayTeamName
    }
}

class MatchupHeaderSectionController: IGListSectionController, IGListSectionType {
    
    var object: MatchupHeader?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 200)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: MatchupHeaderCell.self, for: self, at: index) as! MatchupHeaderCell
        if let game = object {
            cell.homeTeamImage.image = UIImage(named: game.homeTeamName.teamMascotToCity())
            cell.awayTeamImage.image = UIImage(named: game.awayTeamName.teamMascotToCity())
            cell.homeTeamName.text = game.homeTeamName.uppercased()
            cell.awayTeamName.text = game.awayTeamName.uppercased()
        }
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? MatchupHeader
    }
    
    func didSelectItem(at index: Int) {}
    
}


class MatchupHeaderCell: UICollectionViewCell {
    
    
    func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.image = UIImage(named: "Carolina")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8.0
        return imageView
    }
    
    func createLabel() ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = Constants.sectionHeaderFont
        return label
    }
    
    // UI Objects
    
    lazy var homeTeamImage: UIImageView = {
        let homeTeamImage = self.createImageView()
        self.contentView.addSubview(homeTeamImage)
        return homeTeamImage
    }()
    
    lazy var awayTeamImage: UIImageView = {
        let awayTeamImage = self.createImageView()
        self.contentView.addSubview(awayTeamImage)
        return awayTeamImage
    }()
    
    lazy var homeTeamName: UILabel = {
        let homeTeamName = self.createLabel()
        self.contentView.addSubview(homeTeamName)
        return homeTeamName
    }()
    
    lazy var awayTeamName: UILabel = {
        let awayTeamName = self.createLabel()
        self.contentView.addSubview(awayTeamName)
        return awayTeamName
    }()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        homeTeamImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self.snp.centerX).offset(-4)
            make.bottom.greaterThanOrEqualTo(self.snp.bottom).offset(-25)
        }
        
        awayTeamImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
            make.left.equalTo(self.snp.centerX).offset(4)
            make.bottom.greaterThanOrEqualTo(self.snp.bottom).offset(-25)
        }
        
        homeTeamName.snp.makeConstraints { (make) in
            make.top.equalTo(homeTeamImage.snp.bottom).offset(8)
            make.left.equalTo(self.homeTeamImage.snp.left)
        }
        
        awayTeamName.snp.makeConstraints { (make) in
            make.top.equalTo(awayTeamImage.snp.bottom).offset(8)
            make.right.equalTo(self.awayTeamImage.snp.right)
        }
    
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            //            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
}
