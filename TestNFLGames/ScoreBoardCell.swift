//
//  ScoreBoardCell.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit
class ScoreBoardCell: UICollectionViewCell {
    
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate static let font = UIFont.systemFont(ofSize: 17)
    fileprivate static let scoreFont = UIFont.boldSystemFont(ofSize: 22)
    fileprivate static let timeFont = UIFont.systemFont(ofSize: 13)
    
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
    
    func createLabel() ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = ScoreBoardCell.font
        return label
    }
    
    // UI Objects
    lazy var placeLabel: UILabel = {
        let placeLabel = self.createLabel()
        self.contentView.addSubview(placeLabel)
        return placeLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = self.createLabel()
        self.contentView.addSubview(nameLabel)
        return nameLabel
    }()
    
    lazy var scoreLabel: UILabel = {
        let scoreLabel = self.createLabel()
        self.contentView.addSubview(scoreLabel)
        return scoreLabel
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
        let left = ScoreBoardCell.insets.left
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
        
        
        placeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(16)
        }
        
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(placeLabel.snp.right).offset(16)
        }
        
        
        scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self).offset(-16)
        }
        
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
}
