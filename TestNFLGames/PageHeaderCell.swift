//
//  PageHeaderCell.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit

class PageHeader: NSObject {
    
    let title: String
    
    init(title : String ) {
        self.title = title
    }
}


class PageHeaderController : IGListSectionController, IGListSectionType {
    var object: PageHeader?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 80)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: PageHeaderCell.self, for: self, at: index) as! PageHeaderCell
        cell.headerLabel.text = object?.title
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? PageHeader
    }
    
    func didSelectItem(at index: Int) {}
}

class PageHeaderCell: UICollectionViewCell {
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    
  
    func createLabel() ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = Constants.pageHeaderFont
        return label
    }
    
    // UI Objects
    lazy var headerLabel: UILabel = {
        let headerLabel = self.createLabel()
        self.contentView.addSubview(headerLabel)
        return headerLabel
    }()
    
   
    lazy var separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.black.cgColor
        self.contentView.layer.addSublayer(layer)
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        
        let height: CGFloat = 2
        let left = PageHeaderCell.insets.left
        separator.frame = CGRect(x: 0, y: bounds.height - height, width: bounds.width, height: height)
        
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(16)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }

}
