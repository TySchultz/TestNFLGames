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
    
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate static let font = UIFont.systemFont(ofSize: 17)
    fileprivate static let scoreFont = UIFont.boldSystemFont(ofSize: 22)
    fileprivate static let timeFont = UIFont.boldSystemFont(ofSize: 13)
    
    static var singleLineHeight: CGFloat {
        return font.lineHeight + insets.top + insets.bottom
    }
    
    static func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [ NSFontAttributeName: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height) + insets.top + insets.bottom
    }
    
    
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
        label.font = SundayGameCell.scoreFont
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
        timeLabel.font = timeFont
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
        let left = SundayGameCell.insets.left
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
        
        let distanceFromScore = 16
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(8)
            make.left.equalTo(self).offset(8)
        }
        
//        awayTeamImage.snp.makeConstraints { (make) in
//            make.top.equalTo(self).offset(8)
//            make.right.equalTo(self).offset(-8)
//            make.bottom.equalTo(self.snp.bottom).offset(-8)
//            make.width.equalTo(self.snp.height).offset(-16)
//        }
//        
//        homeTeamImage.snp.makeConstraints { (make) in
//            make.top.equalTo(self).offset(8)
//            make.right.equalTo(self.awayTeamImage.snp.left).offset(-8)
//            make.bottom.equalTo(self.snp.bottom).offset(-8)
//            make.width.equalTo(self.snp.height).offset(-16)
//        }
//        
 
        homeTeamName.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.left)
            make.top.equalTo(self.timeLabel.snp.bottom).offset(4)
        }
        
        awayTeamName.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.left)
            make.top.equalTo(self.homeTeamName.snp.bottom).offset(4)
        }
        
        homeTeamScore.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-8)
            make.centerY.equalTo(self.homeTeamName.snp.centerY)
        }
        
        awayTeamScore.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-8)
            make.centerY.equalTo(self.awayTeamName.snp.centerY)
        }
        
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }

}
