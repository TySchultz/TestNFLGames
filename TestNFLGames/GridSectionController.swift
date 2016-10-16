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
import IGListKit
import RealmSwift
class GridItem: NSObject {

    let color: UIColor
    let itemCount: Int

    init(color: UIColor, itemCount: Int) {
        self.color = color
        self.itemCount = itemCount
    }
}

class GridSectionController: IGListSectionController, IGListSectionType {

    var object: Results<Team>?

    override init() {
        super.init()
        self.minimumInteritemSpacing = 8
        self.minimumLineSpacing = 8
        self.inset = UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
        
    }

    func numberOfItems() -> Int {
        return 32
    }

    func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        
        let itemSize = floor(width / 3) - 14
        return CGSize(width: itemSize, height: itemSize*1.35)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: CenterLabelCell.self, for: self, at: index) as! CenterLabelCell
        if let team = object?[index] {
            cell.image.image = UIImage(named: team.teamName.teamMascotToCity())
            cell.label.text = team.teamName
        }
        return cell
    }

    func didUpdate(to object: Any) {
        self.object = object as? Results<Team>
        
        print (self.object?.count)
    }

    func didSelectItem(at index: Int) {}
}
