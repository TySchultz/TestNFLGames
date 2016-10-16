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

class CenterLabelCell: UICollectionViewCell {

    lazy var label: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.clear
        view.textAlignment = .center
        view.textColor = UIColor.white
        view.font = UIFont.boldSystemFont(ofSize: 15)
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Cleveland")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8.0
        self.contentView.addSubview(image)
        return image
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        label.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            
        }
        image.frame = contentView.bounds
        self.layer.cornerRadius = 8.0
    }

}
