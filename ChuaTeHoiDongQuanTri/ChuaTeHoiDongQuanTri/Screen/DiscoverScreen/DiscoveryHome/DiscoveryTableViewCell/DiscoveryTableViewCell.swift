//
//  DiscoveryTableViewCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 08/04/2022.
//

import UIKit

protocol DeepSeachingDelegate : AnyObject {
    func doDeepSearch(area : String,
                      category : String,
                      year : String,
                      subtitles : String,
                      order : String)
}

protocol DeepSeachingMoiveDelegate : AnyObject {
    func doDeepSearch(area : String,
                      category : String,
                      year : String,
                      subtitles : String,
                      order : String)
}

protocol DeepSeachingAnimeDelegate : AnyObject {
    func doDeepSearch(area : String,
                      category : String,
                      year : String,
                      subtitles : String,
                      order : String)
}

class DiscoveryTableViewCell: UITableViewCell {

    @IBOutlet weak var acollectionView: UICollectionView!
    
    var model: ScreeningItems? {
        didSet {
            self.acollectionView.reloadData()
        }
    }
    
    var searchDelegate : DeepSeachingDelegate?
    var searchDelegateMovie : DeepSeachingMoiveDelegate?
    var searchDelegateAnime : DeepSeachingAnimeDelegate?

    var areaParams = ""
    var categoryParams = ""
    var yearParams = ""
    var subParams = ""
    var orderParams = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        registerCell()
    }
    
    private func registerCell() {
        self.acollectionView.registerCell(nibName: DiscoveryCatagoryCLVCell.self)
        self.acollectionView.delegate = self
        self.acollectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDelegate
extension DiscoveryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = self.model?.items else { return }
        
        for item in data {
            item.isSelected = false
        }
        
        switch data[indexPath.row].screeningType {
        case SearchParams.area.rawValue:
            areaParams = data[indexPath.row].params ?? ""
        case SearchParams.category.rawValue:
            categoryParams = data[indexPath.row].params ?? ""
        case SearchParams.year.rawValue:
            yearParams = data[indexPath.row].params ?? ""
        case SearchParams.subtitles.rawValue:
            subParams = data[indexPath.row].params ?? ""
        case SearchParams.order.rawValue:
            orderParams = data[indexPath.row].params ?? ""
        default:
            break
        }
        
        searchDelegate?.doDeepSearch(area: areaParams,
                                     category: categoryParams,
                                     year: yearParams,
                                     subtitles: subParams,
                                     order: orderParams)
        
        searchDelegateMovie?.doDeepSearch(area: areaParams,
                                     category: categoryParams,
                                     year: yearParams,
                                     subtitles: subParams,
                                     order: orderParams)
        
        searchDelegateAnime?.doDeepSearch(area: areaParams,
                                     category: categoryParams,
                                     year: yearParams,
                                     subtitles: subParams,
                                     order: orderParams)
        
        data[indexPath.row].isSelected = true
        
        DispatchQueue.main.async {
            self.acollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.acollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension DiscoveryTableViewCell: UICollectionViewDataSource {
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
extension DiscoveryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let data = self.model?.items else { return CGSize(width: 0, height: self.frame.height) }
        let dynamicWidth = UILabel.textWidth(font: UIFont.systemFont(ofSize: 14), text: data[indexPath.row].name ?? "")
        return CGSize(width: dynamicWidth + 16, height: self.frame.height)
    }
}
