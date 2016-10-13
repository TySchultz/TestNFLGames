//
//  SectionHeaderCell.swift
//  Sports
//
//  Created by Tyler J Schultz on 10/12/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit



class SectionHeader: NSObject {
    
    let title: String
    
    init(title : String ) {
        self.title = title
    }
}


class SectionHeaderController : IGListSectionController, IGListSectionType {
    var object: SectionHeader?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index) as! SectionHeaderCell
        cell.headerLabel.text = object?.title
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? SectionHeader
    }
    
    func didSelectItem(at index: Int) {}
}

class SectionHeaderCell: UICollectionViewCell {
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate static let font = UIFont.boldSystemFont(ofSize: 22)
    
    static var singleLineHeight: CGFloat {
        return font.lineHeight + insets.top + insets.bottom
    }
    
    func createLabel() ->  UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = SectionHeaderCell.font
        return label
    }
    
    // UI Objects
    lazy var headerLabel: UILabel = {
        let headerLabel = self.createLabel()
        self.contentView.addSubview(headerLabel)
        return headerLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        
        let height: CGFloat = 2
        let left = SectionHeaderCell.insets.left
        
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
