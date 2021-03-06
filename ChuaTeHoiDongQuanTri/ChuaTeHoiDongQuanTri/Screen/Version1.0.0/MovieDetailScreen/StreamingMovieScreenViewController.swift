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
    func onConfigureUI(with data: MovieDetail?)
}

// MARK: - StreamingMovieScreen ViewController
class StreamingMovieScreenViewController: BaseViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    var router: StreamingMovieScreenRouterProtocol!
    var viewModel: StreamingMovieScreenViewModelProtocol!
    var movieDetail: MovieDetail?
    var objects = [ListDiffable]()
    var currentEpisode: Int? = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(),
                           viewController: self,
                           workingRangeSize: 2)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .stopPlayingMedia, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .stopPlayingMedia, object: nil)
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
            controller.movieDetail?.seriesNo = self.currentEpisode
            return controller
        case is MovieInfo:
            return StreamingInfoSectionController()
        case is EpisodeCollection:
            let controller = StreamingEpisodeSectionController()
            controller.onHandleDelegate = self
            return controller
        case is Section:
            let controller = StreamingListCollectionSectionController()
            controller.onHandleDelegate = self
            return controller
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

// MARK: - StreamingMovieScreen ViewProtocol
extension StreamingMovieScreenViewController: StreamingMovieScreenViewProtocol {
    func onConfigureUI(with data: MovieDetail?) {
        self.movieDetail = data
        self.title = self.movieDetail?.name
        self.coverImageView.makeBlurImage(targetImageView: self.coverImageView)
        self.coverImageView.setImageCachingv2(targetImageView: self.coverImageView, with: (self.movieDetail?.coverVerticalUrl)!)
    }
    
    func onDidLoadLinkMedia(link: LinkMedia, info: MovieInfo, section: ListCollection, episodeVo: EpisodeCollection) {
        self.objects.removeAll()
        self.objects.append(link)
        self.objects.append(info)
        self.objects.append(episodeVo)
        for item in section.section {
            self.objects.append(item)
        }
        self.adapter.performUpdates(animated: true)
    }
}

//MARK: - onSelectAnotherMediaProtocol
extension StreamingMovieScreenViewController: onSelectAnotherMediaProtocol {
    func onDidSelect(with dataItem: DataModel) {
        self.viewModel.onGetMovieDetail(with: dataItem)
    }
}

extension StreamingMovieScreenViewController: onSelectEpisodeProtocols {
    func didSelect(with data: EpisodeVo?) {
        self.currentEpisode = data?.seriesNo
        self.viewModel.onLoadEpisode(with: data!)
    }
}
