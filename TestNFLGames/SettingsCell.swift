//
//  SettingsCell.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit

class SettingsCell: UICollectionViewCell {
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate static let font = UIFont.systemFont(ofSize: 22, weight: 13)
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
        label.font = SettingsCell.font
        return label
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
    
    // UI Objects
    lazy var contentLabel: UILabel = {
        let contentLabel = self.createLabel()
        self.contentView.addSubview(contentLabel)
        return contentLabel
    }()
    
    lazy var cellImage: UIImageView = {
        let cellImage = self.createImageView()
        self.contentView.addSubview(cellImage)
        return cellImage
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
        let left = SettingsCell.insets.left
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
        
        
        let edgeOffset = 16
        
        contentLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(edgeOffset)
        }
        
        cellImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-edgeOffset)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
            make.width.equalTo(self.snp.height).offset(-16)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
}
