//
//  DetailScreenStatCell.swift
//  TestNFLGames
//
//  Created by Tyler J Schultz on 10/14/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class StatCell: NSObject {
    
    let title: String
    let homeStat: Any
    let awayStat: Any

    init(title : String, homeStat : Any, awayStat: Any) {
        self.title = title
        self.homeStat = homeStat
        self.awayStat = awayStat
    }
}

class DetailScreenStatCell: UICollectionViewCell {

    func createLabel() ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = Constants.mainInfoBold
        return label
    }
    
    // UI Objects
    lazy var titleLabel: UILabel = {
        let titleLabel = self.createLabel()
        titleLabel.font = Constants.subInfoNormal
        self.contentView.addSubview(titleLabel)
        return titleLabel
    }()
    
    lazy var homeStatLabel: UILabel = {
        let homeStatLabel = self.createLabel()
        homeStatLabel.font = Constants.mainInfoBold
        self.contentView.addSubview(homeStatLabel)
        return homeStatLabel
    }()
    
    lazy var awayStatLabel: UILabel = {
        let awayStatLabel = self.createLabel()
        awayStatLabel.font = Constants.mainInfoBold
        self.contentView.addSubview(awayStatLabel)
        return awayStatLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
        
        homeStatLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.centerX).offset(-100)
        }
        
        awayStatLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.centerX).offset(100)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
}
