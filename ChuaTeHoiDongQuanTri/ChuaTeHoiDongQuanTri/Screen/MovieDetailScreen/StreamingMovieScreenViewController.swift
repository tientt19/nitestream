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
    func onDidLoadLinkMedia(link: LinkMedia, info: MovieInfo, section: ListCollection, episodeVo: EpisodeCollection)
}

// MARK: - StreamingMovieScreen ViewController
class StreamingMovieScreenViewController: BaseViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    var router: StreamingMovieScreenRouterProtocol!
    var viewModel: StreamingMovieScreenViewModelProtocol!
    var movieDetail: MovieDetail?
    var objects = [ListDiffable]()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Init
    private func setupInit() {
        self.title = self.movieDetail?.name
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .clear
        self.adapter.collectionView = self.collectionView
        self.coverImageView.makeBlurImage(targetImageView: self.coverImageView)
        self.coverImageView.setImageCachingv2(targetImageView: self.coverImageView, with: (self.movieDetail?.coverVerticalUrl)!)
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
        case is EpisodeCollection:
            return StreamingEpisodeSectionController()
        case is Section:
            return StreamingListCollectionSectionController()
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

// MARK: - StreamingMovieScreen ViewProtocol
extension StreamingMovieScreenViewController: StreamingMovieScreenViewProtocol {
    func onDidLoadLinkMedia(link: LinkMedia, info: MovieInfo, section: ListCollection, episodeVo: EpisodeCollection) {
        self.objects.append(link)
        self.objects.append(info)
        self.objects.append(episodeVo)
        for item in section.section {
            self.objects.append(item)
        }
        self.adapter.performUpdates(animated: true)
    }
}
