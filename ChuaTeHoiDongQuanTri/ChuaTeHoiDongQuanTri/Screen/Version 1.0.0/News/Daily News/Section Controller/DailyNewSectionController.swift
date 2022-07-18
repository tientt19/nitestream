//
//  DailyNewSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//

import Foundation
import IGListKit

protocol DailyNewsSectionDelegate: AnyObject {
    func onGetDataPass(with model: NewsModel?)
}

class DailyNewsSectionController: ListSectionController {
    var currentIem: DailyNewsModel?
    var delegate: DailyNewsSectionDelegate?
    
    override init() {
        super.init()
        self.minimumLineSpacing = 10
        self.inset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? DailyNewsModel else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return self.currentIem?.list?.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: CellCollectionViewDailyNews.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! CellCollectionViewDailyNews
        cell.model = self.currentIem?.list?[index]
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let data = self.currentIem?.list?[index]
        let collectionViewWidth = ((collectionContext?.containerSize.width)! - 32)
        let collectionViewHeight = estimateFrameForText(text: data?.title ?? "" , width: collectionViewWidth).height +
        estimateFrameForText(text: "\(String(describing: data?.createTime))" , width: collectionViewWidth).height +
        estimateFrameForText(text: data?.introduction ?? "", width: collectionViewWidth).height +
        (collectionViewWidth * 380/677) + 30
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    override func didSelectItem(at index: Int) {
        self.delegate?.onGetDataPass(with: self.currentIem?.list?[index])
    }
}

extension DailyNewsSectionController {
    private func estimateFrameForText(text: String, width: CGFloat) -> CGRect {
        let height: CGFloat = 999
        let size = CGSize(width: width, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
}
