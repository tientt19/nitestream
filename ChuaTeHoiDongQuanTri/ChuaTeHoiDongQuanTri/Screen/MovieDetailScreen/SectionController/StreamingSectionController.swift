//
//  StreamingSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 10/05/2022.
//

import Foundation
import IGListKit

class StreamingSectionController: ListSectionController {
    var currentIem: LinkMedia?
    var subRemoteURL: String?
    var mediaIsPlaying = false
    var movieDetail: MovieDetail?

    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? LinkMedia else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: CellCollectionStreaming.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! CellCollectionStreaming
        if self.mediaIsPlaying == false {
            self.mediaIsPlaying.toggle()
            cell.playMedia(link: self.currentIem!, and: self.getLinkSub(self.movieDetail?.seriesNo ?? 0))
        }
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = collectionContext?.containerSize.width ?? 0
        let collectionViewHeight = (collectionViewWidth * 9) / 16
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    override func didSelectItem(at index: Int) { }
}

//MARK: - configure
extension StreamingSectionController {
    func getLinkSub(_ seriesNo: Int) -> String {
        if let subLinks = self.movieDetail?.episodeVo[seriesNo].subtitlingList {
            for item in subLinks {
                if item.languageAbbr == "vi" {
                    self.subRemoteURL = item.subtitlingUrl
                }
            }
            
            if self.subRemoteURL == "" {
                for item in subLinks {
                    if item.languageAbbr == "en" {
                        self.subRemoteURL = item.subtitlingUrl
                    }
                }
            }
        }
        return self.subRemoteURL ?? ""
    }
}
