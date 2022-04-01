//
//  MovieDetailScreenViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//  
//

import UIKit
import StreamingTienPro

class MovieDetailScreenViewController: BaseViewController {
    // MARK: - Properties
    var presenter: MovieDetailScreenPresenterProtocol?
    
    @IBOutlet weak var bannerImageView : UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var rankingMovie : UILabel!
    @IBOutlet weak var likeList : UICollectionView!
    @IBOutlet weak var mediaPlayerView : UIView!
    @IBOutlet weak var contentHeight : NSLayoutConstraint!
    @IBOutlet weak var shortContent : UILabel!
    
    internal var dataSource : DetailDataSource?
    var movieDetail = MovieDetail(fromDictionary: ["" : ""])
    var subRemoteURL = String()
    var moviePlayer = MovieStreaming()

    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataSource = MovieDetailDataSource(entities: movieDetail, with: presenter!)
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        moviePlayer.pause()
    }
}

//MARK: - Hanle View
extension MovieDetailScreenViewController {
    func configureUI() {
        setUpBaseView()
        stopLoadingAnimate()
        
        ///  Configure Base UI
        bannerImageView.setImageCaching(targetImageView: bannerImageView, with: movieDetail.coverVerticalUrl)
        movieName.text = movieDetail.name
        navigationItem.title = movieDetail.name
        
        if let scored = movieDetail.score , let year = movieDetail.year {
            rankingMovie.text = "Scored : \(String(describing: scored)) |  Year : \(year)"
        } else { rankingMovie.text = "" }
        
        if let temp = movieDetail.introduction {
            shortContent.text = temp
        } else { shortContent.text = "" }
        
        /// - calculate height of scroll view
        contentHeight.constant = movieName.frame.height + rankingMovie.frame.height + shortContent.frame.height + (dataSource?.getContentHeight())! + mediaPlayerView.frame.height
        
        /// Get Movie Subfile
        self.subRemoteURL = (dataSource?.getLinkSub(0))!
        // reload
        likeList.reloadData()
    }
    
    private func registerCell() {
        likeList.registerCell(nibName: TopSearchCell.self)
        likeList.registerCell(nibName: ListInfoCell.self)
        likeList.registerCellForHeader(nibName: MainHeader.self)
        likeList.registerCellForFooter(nibName: MainFooter.self)
        bannerImageView.makeBlurImage(targetImageView: bannerImageView)
    }
}

extension MovieDetailScreenViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataSource?.didSelect(collectionView: collectionView, indexPath: indexPath)
    }
}

//MARK: - UICollectionViewDataSource
extension MovieDetailScreenViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataSource?.episodeVo.count ?? 0 > 1 {
            if section == 0 {
                return (dataSource?.episodeVo.count)!
            } else { return (dataSource?.sections[section].data.count)! }
        }
        return (dataSource?.sections[section].data.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (dataSource?.itemCell(collectionView: collectionView, indexPath: indexPath))!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return (dataSource?.configureHeader(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath))!
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MovieDetailScreenViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 5 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        (dataSource?.sizeForItem(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath))!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: likeList.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: likeList.frame.width, height: 10)
    }
}

//MARK: - MovieDetailScreenViewProtocol
extension MovieDetailScreenViewController: MovieDetailScreenViewProtocol{
 
    // TODO: Implement View Output Methods
    func playMedia(link: LinkMedia) {
        self.moviePlayer.configure(in: self.mediaPlayerView)
        if let linkMedia = URL(string: link.mediaUrl) {
            self.moviePlayer.streaming(with: linkMedia, subRemote: self.subRemoteURL)
        }
    }
    
    func configureNewData(_ data: MovieDetail) {
        moviePlayer.pause()
        self.movieDetail = data
        dataSource = MovieDetailDataSource(entities: data, with: presenter!)
        configureUI()
    }
}
