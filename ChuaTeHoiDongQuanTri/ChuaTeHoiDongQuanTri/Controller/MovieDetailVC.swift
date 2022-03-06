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
import SwiftUI

class Section : Hashable {
    var id = UUID()
    
    var title: String
    var data: [DataModel]
    
    init(data: [DataModel], title: String) {
        self.data = data
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}

class DataModel : Hashable {
    var id : String!
    var name : String!
    var category : Int!
    var coverHorizontalUrl : String!
    
    init(id : String, category : Int, name : String, coverHorizontalUrl : String){
        self.category = category
        self.coverHorizontalUrl = coverHorizontalUrl
        self.id = id
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DataModel, rhs: DataModel) -> Bool {
        lhs.id == rhs.id
    }
}

class MovieDetailVC: BaseViewController {
    
    @IBOutlet weak var bannerImageView : UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var rankingMovie : UILabel!
    @IBOutlet weak var intro : UILabel!
    @IBOutlet weak var likeList : UICollectionView!
    @IBOutlet weak var mediaPlayerView : UIView!
    @IBOutlet weak var heightScrollView : NSLayoutConstraint!
    
    var movieDetail = MovieDetail(fromDictionary: ["" : ""])
    var movieDetailPresent : MovieDetailPresenter!
    var subRemoteURL = String()
    
    var moviePlayer = MovieStreaming()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        HandlingView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
        likeList.registerCell(nibName: HorizontallyCell.self)
        likeList.registerCell(nibName: ListInfoCell.self)
        likeList.registerCellForHeader(nibName: MainHeader.self)
        likeList.registerCellForFooter(nibName: MainFooter.self)
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
        heightScrollView.constant = movieDetailPresent.getHeightOfContent()
        
        
        //MARK: - Configure Base UI
        bannerImageView.setImage(targetImageView: bannerImageView, with: movieDetail.coverHorizontalUrl)
        movieName.text = movieDetail.name
        
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

extension MovieDetailVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movieDetailPresent.getSectionData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieDetailPresent.getEpisodeList().count > 1 {
            if section == 0 {
                return movieDetailPresent.getEpisodeList().count
            } else { return 1 }
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if movieDetailPresent.getEpisodeList().count > 1 {
            if indexPath.section == 0 {
                let cell = collectionView.dequeue(cellClass: ListInfoCell.self, forIndexPath: indexPath)
                cell.configure(movieDetailPresent.getEpisodeList()[indexPath.row])
                return cell
            }
        }
        let cell = collectionView.dequeue(cellClass: HorizontallyCell.self, forIndexPath: indexPath)
        cell.configure(data: movieDetailPresent.getSectionData()[indexPath.section].data)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueHeader(cellClass: MainHeader.self, OfKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
            header.configure(movieDetailPresent.getSectionData()[indexPath.section].title)
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueFooter(cellClass: MainFooter.self, OfKind: UICollectionView.elementKindSectionFooter, forIndexPath: indexPath)
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension MovieDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentHeight = (movieDetailPresent.getHeightOfContent() / CGFloat(movieDetailPresent.getSectionData().count)) - 60
        
        if movieDetailPresent.getEpisodeList().count > 1 {
            if indexPath.section == 0 {
                return CGSize(width: 50, height: 50)
            }
        }
        
        return CGSize(width: likeList.frame.width, height: contentHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: likeList.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: likeList.frame.width, height: 10)
    }
}

extension MovieDetailVC : updateMovieDetail {
    func loadDetail() {
        DispatchQueue.main.async {
            self.movieDetail = self.movieDetailPresent.getDetailMovie()
            self.HandlingView()
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            if let linkMedia = URL(string: self.movieDetailPresent.getLinkMedia().mediaUrl) {
                self.moviePlayer.configure(in: self.mediaPlayerView)
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


