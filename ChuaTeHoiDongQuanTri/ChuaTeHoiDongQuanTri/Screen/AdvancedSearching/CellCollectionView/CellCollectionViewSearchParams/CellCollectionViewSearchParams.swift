//
//  CellCollectionViewSearchParams.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//

import UIKit

protocol onSendParmasToSearchProtocols: AnyObject {
    func onSendParams(with params: [String:Any]?)
}

class CellCollectionViewSearchParams: UICollectionViewCell {
    
    @IBOutlet weak var acollectionView: UICollectionView!
    var delegate: onSendParmasToSearchProtocols!
    
    var model: ScreeningItem? {
        didSet {
            self.acollectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerCell()
    }
    
    private func registerCell() {
        self.acollectionView.registerCell(nibName: DiscoveryCatagoryCLVCell.self)
        self.acollectionView.delegate = self
        self.acollectionView.dataSource = self
    }

}

//MARK: - UICollectionViewDelegate
extension CellCollectionViewSearchParams: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = self.model?.items else { return }
        
        for item in data {
            item.isSelected = false
        }
        
        data[indexPath.row].isSelected = true
        
        DispatchQueue.main.async {
            self.acollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.acollectionView.reloadData()
        }
                    
        switch self.model?.name {
        case DiscoveryCategoryParams.area.toString:
            DiscoverySearchingUtility.share.discoverySearchingModel.area = data[indexPath.row].params ?? ""
        case DiscoveryCategoryParams.cate.toString:
            DiscoverySearchingUtility.share.discoverySearchingModel.category = data[indexPath.row].params ?? ""
        case DiscoveryCategoryParams.year.toString:
            DiscoverySearchingUtility.share.discoverySearchingModel.year = data[indexPath.row].params ?? ""
        case DiscoveryCategoryParams.sub.toString:
            DiscoverySearchingUtility.share.discoverySearchingModel.subtitles = data[indexPath.row].params ?? ""
        case DiscoveryCategoryParams.order.toString:
            DiscoverySearchingUtility.share.discoverySearchingModel.order = data[indexPath.row].params ?? "up"
        default:
            break
        }
        
        switch self.model?.id {
        case 4,5,6:
            self.delegate.onSendParams(with: DiscoverySearchingUtility.share.discoverySearchingModel.toDictionary(type: DiscoveryParams.TVSeries.toString))
        case 1,2,3:
            self.delegate.onSendParams(with: DiscoverySearchingUtility.share.discoverySearchingModel.toDictionary(type: DiscoveryParams.Movie.toString))
        case 7,8,9:
            self.delegate.onSendParams(with: DiscoverySearchingUtility.share.discoverySearchingModel.toDictionary(type: DiscoveryParams.Anime.toString))
        default:
            break
        }
        
    }
}

//MARK: - UICollectionViewDataSource
extension CellCollectionViewSearchParams: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = self.model else {
            return 0
        }
        guard let items = data.items else { return 0}
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = acollectionView.dequeue(cellClass: DiscoveryCatagoryCLVCell.self, forIndexPath: indexPath)
        guard let data = self.model?.items else { return cell }
        cell.item = data[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CellCollectionViewSearchParams: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let data = self.model?.items else { return CGSize(width: 0, height: self.frame.height) }
        let dynamicWidth = UILabel.textWidth(font: UIFont.systemFont(ofSize: 14), text: data[indexPath.row].name ?? "")
        return CGSize(width: dynamicWidth + 16, height: self.frame.height)
    }
}
