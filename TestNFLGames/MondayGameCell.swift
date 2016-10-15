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
        label.font = Constants.mainInfoNormal
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
        homeTeamScore.font = Constants.sectionHeaderFont
        self.contentView.addSubview(homeTeamScore)
        return homeTeamScore
    }()
    
    lazy var awayTeamScore: UILabel = {
        let awayTeamScore = self.createLabel()
        awayTeamScore.font = Constants.sectionHeaderFont
        self.contentView.addSubview(awayTeamScore)
        return awayTeamScore
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = self.createLabel()
        timeLabel.font = Constants.subInfoNormal
        self.contentView.addSubview(timeLabel)
        return timeLabel
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
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
        
        let lightGrayColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).cgColor
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: self.frame.height-100, width: self.frame.width, height: 100)
        gradient.colors = [UIColor.white.cgColor, lightGrayColor]
        gradient.name = "bottomGradient"
        self.contentView.layer.insertSublayer(gradient, at: 0)
        self.contentView.layer.masksToBounds = false

    }

    override var isHighlighted: Bool {
        didSet {
//            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
}

extension MondayGameCell {
    
}
