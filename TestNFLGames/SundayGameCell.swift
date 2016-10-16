//
//  SundayGameCell.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit

class SundayGameCell: UICollectionViewCell {
    
    
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
        label.font = Constants.mainInfoBold
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
    
    lazy var homeTeamScore: UILabel = {
        let homeTeamScore = self.createLabel()
        self.contentView.addSubview(homeTeamScore)
        return homeTeamScore
    }()
    
    lazy var awayTeamScore: UILabel = {
        let awayTeamScore = self.createLabel()
        self.contentView.addSubview(awayTeamScore)
        return awayTeamScore
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = self.createLabel()
        timeLabel.font = Constants.subInfoNormal
        self.contentView.addSubview(timeLabel)
        return timeLabel
    }()
    
    lazy var separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1).cgColor
        self.contentView.layer.addSublayer(layer)
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        
        let height: CGFloat = 0.5
        separator.frame = CGRect(x: 16, y: bounds.height - height, width: bounds.width - 16, height: height)
        
        let distanceFromScore = 16
        
        let imageInset = 16

        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(8)
            make.left.equalTo(self).offset(16)
        }
        
        awayTeamImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(imageInset)
            make.right.equalTo(self).offset(-8)
            make.bottom.equalTo(self.snp.bottom).offset(-imageInset)
            make.width.equalTo(self.snp.height).offset(-16)
        }
        
        homeTeamImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(imageInset)
            make.right.equalTo(self.awayTeamImage.snp.left).offset(-8)
            make.bottom.equalTo(self.snp.bottom).offset(-imageInset)
            make.width.equalTo(self.snp.height).offset(-16)
        }
        
 
        homeTeamName.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.left)
            make.top.equalTo(self.timeLabel.snp.bottom).offset(4)
        }
        
        awayTeamName.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.left)
            make.top.equalTo(self.homeTeamName.snp.bottom).offset(4)
        }
        
        homeTeamScore.snp.makeConstraints { (make) in
            make.right.equalTo(self.homeTeamImage.snp.left).offset(-16)
            make.centerY.equalTo(self.homeTeamName.snp.centerY)
        }
        
        awayTeamScore.snp.makeConstraints { (make) in
            make.right.equalTo(self.homeTeamImage.snp.left).offset(-16)
            make.centerY.equalTo(self.awayTeamName.snp.centerY)
        }
        
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }

}
