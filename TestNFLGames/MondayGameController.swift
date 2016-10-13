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

class MondayGameController: IGListSectionController, IGListSectionType {

    var object: Monday?

    func numberOfItems() -> Int {
        return 1
    }

    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 270)
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: MondayGameCell.self, for: self, at: index) as! MondayGameCell
        cell.homeTeamImage.image = UIImage(named: "Cleveland")
        cell.awayTeamImage.image = UIImage(named: "Seattle")
        cell.homeTeamName.text = "Cleveland"
        cell.awayTeamName.text = "Seattle"
        cell.homeTeamScore.text = "23"
        cell.awayTeamScore.text = "43"
        cell.timeLabel.text = "Final"
        return cell
    }

    func didUpdate(to object: Any) {
        self.object = object as? Monday
    }

    func didSelectItem(at index: Int) {

    }

}
