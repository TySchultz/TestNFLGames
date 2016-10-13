/**
 Copyright (c) 2016-present, Facebook, Inc. All rights reserved.

 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit
import SnapKit

class MondayGameCell: UICollectionViewCell {

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
        label.font = MondayGameCell.font
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
        homeTeamScore.font = scoreFont
        self.contentView.addSubview(homeTeamScore)
        return homeTeamScore
    }()
    
    lazy var awayTeamScore: UILabel = {
        let awayTeamScore = self.createLabel()
        awayTeamScore.font = scoreFont
        self.contentView.addSubview(awayTeamScore)
        return awayTeamScore
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = self.createLabel()
        timeLabel.font = timeFont
        self.contentView.addSubview(timeLabel)
        return timeLabel
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        
        let height: CGFloat = 0.5
        let left = MondayGameCell.insets.left
        
        homeTeamImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self.snp.centerX).offset(-4)
            make.bottom.greaterThanOrEqualTo(self.snp.bottom).offset(-74)
        }
        
        awayTeamImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
            make.left.equalTo(self.snp.centerX).offset(4)
            make.bottom.greaterThanOrEqualTo(self.snp.bottom).offset(-74)
        }
        
        homeTeamName.snp.makeConstraints { (make) in
            make.top.equalTo(homeTeamImage.snp.bottom).offset(8)
            make.left.equalTo(self).offset(8)
        }
        
        awayTeamName.snp.makeConstraints { (make) in
            make.top.equalTo(awayTeamImage.snp.bottom).offset(8)
            make.right.equalTo(self).offset(-8)
        }
        
        homeTeamScore.snp.makeConstraints { (make) in
            make.top.equalTo(homeTeamImage.snp.bottom).offset(8)
            make.right.equalTo(self.snp.centerX).offset(-4)
        }
        
        awayTeamScore.snp.makeConstraints { (make) in
            make.top.equalTo(awayTeamImage.snp.bottom).offset(8)
            make.left.equalTo(self.snp.centerX).offset(4)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-8)
            make.left.equalTo(self).offset(8)
        }
    }

    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
}

extension MondayGameCell {
    
}
