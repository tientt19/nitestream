//
//  
//  StreamingMovieScreenViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 10/05/2022.
//
//

import UIKit
import IGListKit

// MARK: - ViewProtocol
protocol StreamingMovieScreenViewProtocol: AnyObject {
    func onDidLoadLinkMedia(link: LinkMedia, info: MovieInfo)
}

// MARK: - StreamingMovieScreen ViewController
class StreamingMovieScreenViewController: BaseViewController {
    var router: StreamingMovieScreenRouterProtocol!
    var viewModel: StreamingMovieScreenViewModelProtocol!
    var movieDetail: MovieDetail?
    var objects = [ListDiffable]()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let blurImageViewCover: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad(with: self.movieDetail)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = self.view.bounds
        self.blurImageViewCover.frame = self.collectionView.bounds
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Init
    private func setupInit() {
        self.title = self.movieDetail?.name
        self.view.addSubview(self.blurImageViewCover)
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .clear
        self.adapter.collectionView = self.collectionView
        self.blurImageViewCover.setImageCachingv2(targetImageView: self.blurImageViewCover, with: (self.movieDetail?.coverVerticalUrl)!)
        self.adapter.dataSource = self
    }
    
    // MARK: - Action
    
}

//MARK: - ListAdapterDataSource
extension StreamingMovieScreenViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is LinkMedia:
            let controller = StreamingSectionController()
            controller.movieDetail = self.movieDetail
            return controller
        case is MovieInfo:
            return StreamingInfoSectionController()
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

// MARK: - StreamingMovieScreen ViewProtocol
extension StreamingMovieScreenViewController: StreamingMovieScreenViewProtocol {
    func onDidLoadLinkMedia(link: LinkMedia, info: MovieInfo) {
        self.objects.append(link)
        self.objects.append(info)
        self.adapter.performUpdates(animated: true)
    }
}
