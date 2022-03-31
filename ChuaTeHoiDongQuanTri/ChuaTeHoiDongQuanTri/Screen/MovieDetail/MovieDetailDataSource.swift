//
//  MovieDetailDataSource.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 31/03/2022.
//

import Foundation
import UIKit

class MovieDetailDataSource : DetailDataSource {

    private weak var presenter: MovieDetailScreenPresenterProtocol?
    
    var entities = MovieDetail(fromDictionary: ["" : ""])
    var sections = [Section]()
    var episodeVo = [EpisodeVo]()
    var subRemoteURL = String()
    var contentHeight = Int()
    var numberOfItems = Int()
    
    init(entities: MovieDetail,with  presenter: MovieDetailScreenPresenterProtocol) {
        self.entities = entities
        self.presenter = presenter
        configureSection()
    }
    
    func getContentHeight() -> CGFloat {
        return CGFloat(contentHeight)
    }
    
    func itemCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if episodeVo.count > 1 {
            if indexPath.section == 0 {
                let cell = collectionView.dequeue(cellClass: ListInfoCell.self, forIndexPath: indexPath)
                cell.configure(episodeVo[indexPath.row])
                return cell
            }
        }
        
        let cell = collectionView.dequeue(cellClass: TopSearchCell.self, forIndexPath: indexPath)
        let imageurl = sections[indexPath.section].data[indexPath.row].coverHorizontalUrl ?? ""
        let name = sections[indexPath.section].data[indexPath.row].name ?? ""
        cell.configure(imageurl,name)
        return cell
    }
    
    func prefetchingData(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath) {

    }
    
    func configureHeader(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueHeader(cellClass: MainHeader.self, OfKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
            header.configure(sections[indexPath.section].title)
            header.disableExpandButton()
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueFooter(cellClass: MainFooter.self, OfKind: UICollectionView.elementKindSectionFooter, forIndexPath: indexPath)
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func sizeForItem(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if episodeVo.count > 1 {
            if indexPath.section == 0 {
                return CGSize(width: 50, height: 50)
            }
        }
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func configureSection() {
        sections = [Section]()
        episodeVo = [EpisodeVo]()
        subRemoteURL = String()
        contentHeight = Int()
        
        if let episodeList = entities.episodeVo {
            if episodeList.count > 1 {
                self.episodeVo = episodeList
                sections.append(Section(data: [DataModel](), title: "Episodes"))
                let parentWidth = UIScreen.main.bounds.width - 10*2
                let x = (episodeList.count * 50)
                if x > Int(parentWidth) {
                    let lines = (x / Int(parentWidth)) + 1
                    contentHeight += (lines * 50) + 70
                } else {
                    contentHeight += 120
                }
            }
        }
        
        if let reflist = entities.refList {
            if reflist.count != 0 {
                var refLists = [DataModel]()
                reflist.forEach { data in
                    let dataItems = DataModel(id: data.id,
                                              category: data.category,
                                              name: data.name,
                                              coverHorizontalUrl: data.coverHorizontalUrl)
                    refLists.append(dataItems)
                }
                sections.append(Section(data: refLists, title: "In this series"))
                contentHeight += 70 + (((reflist.count)*80) + (reflist.count - 1)*5)
            }
        }
        
        if let likelist = entities.likeList {
            if likelist.count != 0 {
                var likeLists = [DataModel]()
                likelist.forEach { data in
                    let dataItems = DataModel(id: data.id,
                                              category: data.category,
                                              name: data.name,
                                              coverHorizontalUrl: data.coverHorizontalUrl)
                    likeLists.append(dataItems)
                }
                sections.append(Section(data: likeLists, title: "Similar to this"))
                contentHeight += 70 + (((likelist.count)*80) + (likelist.count - 1)*5)
            }
        }
        
        //MARK: - Get Link Media
        let listEpisode = entities.episodeVo.map { x in x.id }
        let definition = entities.episodeVo[0].definitionList[0].code
        
        presenter?.loadLinkMedia(entities.id, entities.category, listEpisode[0]!, definition!)
    }
    
    func getLinkSub(_ seriesNo: Int) -> String {
        if let subLinks = entities.episodeVo[seriesNo].subtitlingList {
            for item in subLinks {
                if item.languageAbbr == "vi" {
                    self.subRemoteURL = item.subtitlingUrl
                }
            }
            
            if subRemoteURL == "" {
                for item in subLinks {
                    if item.languageAbbr == "en" {
                        self.subRemoteURL = item.subtitlingUrl
                    }
                }
            }
        }
        return self.subRemoteURL
    }
}
