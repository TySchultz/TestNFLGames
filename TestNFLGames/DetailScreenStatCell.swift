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
    let homeStat: String
    let awayStat: String

    init(title : String, homeStat : String, awayStat: String) {
        self.title = title
        self.homeStat = homeStat
        self.awayStat = awayStat
    }
}

class DetailScreenStatCell: UICollectionViewCell {
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate static let font = UIFont.systemFont(ofSize: 22, weight: 13)
    

    func createLabel() ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = DetailScreenStatCell.font
        return label
    }

    
    // UI Objects
    lazy var titleLabel: UILabel = {
        let titleLabel = self.createLabel()
        self.contentView.addSubview(titleLabel)
        return titleLabel
    }()
    
    lazy var homeStatLabel: UILabel = {
        let homeStatLabel = self.createLabel()
        self.contentView.addSubview(homeStatLabel)
        return homeStatLabel
    }()
    
    lazy var awayStatLabel: UILabel = {
        let awayStatLabel = self.createLabel()
        self.contentView.addSubview(awayStatLabel)
        return awayStatLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
        
        homeStatLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.titleLabel.snp.left).offset(-100)
        }
        
        awayStatLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.titleLabel.snp.right).offset(100)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
}
