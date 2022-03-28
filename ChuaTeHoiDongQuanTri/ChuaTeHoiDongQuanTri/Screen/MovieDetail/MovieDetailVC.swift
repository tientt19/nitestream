//
//  MovieDetailVC.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 27/02/2022.
//

import UIKit
import Kingfisher
import Foundation
import AVKit
import StreamingTienPro

class MovieDetailVC: BaseViewController {
    
    @IBOutlet weak var bannerImageView : UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var rankingMovie : UILabel!
    @IBOutlet weak var intro : UILabel!
    @IBOutlet weak var likeList : UICollectionView!
    @IBOutlet weak var mediaPlayerView : UIView!
    @IBOutlet weak var contentHeight : NSLayoutConstraint!
    @IBOutlet weak var movieNamelb: UILabel!
    @IBOutlet weak var shortContent : UILabel!
    @IBOutlet weak var rateLabel : UILabel!
    
    var movieDetail = MovieDetail(fromDictionary: ["" : ""])
    var movieDetailPresent : MovieDetailPresenter!
    var subRemoteURL = String()
    
    var moviePlayer = MovieStreaming()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HandlingView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        moviePlayer.pause()
    }
    
    init(_ movieDetailData : MovieDetail) {
        super.init(nibName: nil, bundle: nil)
        self.movieDetail = movieDetailData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailVC {
    private func registerCell() {
        likeList.registerCell(nibName: TopSearchCell.self)
        likeList.registerCell(nibName: ListInfoCell.self)
        likeList.registerCellForHeader(nibName: MainHeader.self)
        likeList.registerCellForFooter(nibName: MainFooter.self)
        likeList.prefetchDataSource = self
        bannerImageView.makeBlurImage(targetImageView: bannerImageView)
        
        movieDetailPresent = MovieDetailPresenter(view: self)
    }
    
    func HandlingView() {
        setUpBaseView()
        stopLoadingAnimate()
        
        //MARK: - Configure Default Data
        if movieDetailPresent.getSectionData().isEmpty {
            let _ = movieDetailPresent.defaultVatlue(data: self.movieDetail)
        }
        
        movieDetailPresent.configureToSection()
        contentHeight.constant = movieNamelb.frame.height + rateLabel.frame.height + shortContent.frame.height + movieDetailPresent.getContentHeigt() + mediaPlayerView.frame.height 

        //MARK: - Configure Base UI
        bannerImageView.setImage(targetImageView: bannerImageView, with: movieDetail.coverHorizontalUrl)
        movieName.text = movieDetail.name
        navigationItem.title = movieDetail.name
        
        if let scored = movieDetail.score , let year = movieDetail.year {
            rankingMovie.text = "Scored : \(String(describing: scored)) |  Year : \(year)"
        } else { rankingMovie.text = "" }
        
        if let temp = movieDetail.introduction {
            intro.text = temp
        } else { intro.text = "" }
        
        //MARK: - Get Movie Subfile
        self.subRemoteURL = movieDetailPresent.getLinkSub(0)
        
        //MARK: - Get Link Media
        let listEpisode = movieDetail.episodeVo.map { x in x.id }
        let definition = movieDetail.episodeVo[0].definitionList[0].code
        
        movieDetailPresent.loadLinkMedia(movieDetail.id, movieDetail.category, listEpisode[0]!, definition!)
        
        //MARK: - Reload
        likeList.reloadData()
    }
}

extension MovieDetailVC : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? TopSearchCell {
                let imageurl = movieDetailPresent.getSectionData()[indexPath.section].data[indexPath.row].coverHorizontalUrl ?? ""
                let name = movieDetailPresent.getSectionData()[indexPath.section].data[indexPath.row].name ?? ""
                cell.configure(imageurl,name)
            }
        }
    }
}

//MARK: - UICollectionViewDelegate
extension MovieDetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? ListInfoCell {
            if let episodeID = selectedCell.dataPassed.id,
               let definition = movieDetail.episodeVo[selectedCell.dataPassed.seriesNo - 1].definitionList[0].code {
                self.subRemoteURL = movieDetailPresent.getLinkSub(selectedCell.dataPassed.seriesNo - 1)
                movieDetailPresent.loadLinkMedia(movieDetail.id, movieDetail.category, episodeID, definition)
            }
        }
        
        if movieDetailPresent.getEpisodeList().count > 1 {
            if indexPath.section == 0 {
                
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MovieDetailVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movieDetailPresent.getSectionData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieDetailPresent.getEpisodeList().count > 1 {
            if section == 0 {
                return movieDetailPresent.getEpisodeList().count
            } else { return movieDetailPresent.getSectionData()[section].data.count }
        }
        return movieDetailPresent.getSectionData()[section].data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if movieDetailPresent.getEpisodeList().count > 1 {
            if indexPath.section == 0 {
                let cell = collectionView.dequeue(cellClass: ListInfoCell.self, forIndexPath: indexPath)
                cell.configure(movieDetailPresent.getEpisodeList()[indexPath.row])
                return cell
            }
        }
        let cell = collectionView.dequeue(cellClass: TopSearchCell.self, forIndexPath: indexPath)
        let imageurl = movieDetailPresent.getSectionData()[indexPath.section].data[indexPath.row].coverHorizontalUrl ?? ""
        let name = movieDetailPresent.getSectionData()[indexPath.section].data[indexPath.row].name ?? ""
        cell.configure(imageurl,name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueHeader(cellClass: MainHeader.self, OfKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
            header.configure(movieDetailPresent.getSectionData()[indexPath.section].title)
            header.disableExpandButton()
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueFooter(cellClass: MainFooter.self, OfKind: UICollectionView.elementKindSectionFooter, forIndexPath: indexPath)
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension MovieDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if movieDetailPresent.getEpisodeList().count > 1 {
            if indexPath.section == 0 {
                return CGSize(width: 50, height: 50)
            }
        }
        return CGSize(width: likeList.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: likeList.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: likeList.frame.width, height: 10)
    }
}
//MARK: - updateMovieDetail

extension MovieDetailVC : updateMovieDetail {
    func loadDetail() {
        DispatchQueue.main.async {
            self.movieDetail = self.movieDetailPresent.getDetailMovie()
            self.HandlingView()
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.moviePlayer.configure(in: self.mediaPlayerView)
            if let linkMedia = URL(string: self.movieDetailPresent.getLinkMedia().mediaUrl) {
                self.moviePlayer.streaming(with: linkMedia, subRemote: self.subRemoteURL)
            }
        }
    }
}

extension MovieDetailVC : triggerCellDelegate {
    func trigger(dataPassed: DataModel) {
        activityIndicatorView.startAnimating()
        movieDetailPresent.getMovieDetail(Int(dataPassed.id)!, dataPassed.category)
    }
}


