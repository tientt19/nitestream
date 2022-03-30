//
//  MovieDetailScreenViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//  
//

import UIKit

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
    
    var movieDetail = MovieDetail(fromDictionary: ["" : ""])
    var movieDetailPresent : MovieDetailPresenter!
    var subRemoteURL = String()

    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBaseView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.handleFetching(movieDetail)
    }
}

//MARK: - Hanle View
extension MovieDetailScreenViewController {
    func handleView() {
    }
}

//MARK: - MovieDetailScreenViewProtocol
extension MovieDetailScreenViewController: MovieDetailScreenViewProtocol{
    // TODO: Implement View Output Methods
}
