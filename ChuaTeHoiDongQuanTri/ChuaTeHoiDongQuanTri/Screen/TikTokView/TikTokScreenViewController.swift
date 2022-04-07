//
//  TikTokScreenViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 04/04/2022.
//  
//

import UIKit

class TikTokScreenViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tiktokTableView : UITableView!
    
    var presenter: TikTokScreenPresenterProtocol?
    var dataSource : TikTokTableViewDataSource?
    var reviewData = [ReviewMedia]()
    var tempData = [TikTokModel]()
    var index = 0

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.fetchData(with: index)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.appEnteredFromBackground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func setupView() {
        dataSource = TikTokTableViewDataSource(entities: tempData, with: presenter!)
        tiktokTableView.registerCell(nibName: tiktokTableViewCell.self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pausePlayeVideos()
    }
}

//MARK: - UITableViewDataSource
extension TikTokScreenViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataSource?.itemCell(tableView: tableView, indexPath: indexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource!.numberOfItems - 1 {
            index += 1
            dataSource?.loadMore(with: index)
        }
    }
}

//MARK: - UITableViewDelegate
extension TikTokScreenViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tiktokTableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? ASAutoPlayVideoLayerContainer, let _ = videoCell.videoURL {
            ASVideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pausePlayeVideos()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pausePlayeVideos()
        }
    }
}

//MARK: - TikTokScreenViewProtocol
extension TikTokScreenViewController: TikTokScreenViewProtocol{
    // TODO: Implement View Output Methods
    func showStreaming(data: [TikTokModel]) {
        dataSource = TikTokTableViewDataSource(entities: data, with: presenter!)
    }
    
    func configureView(data: [ReviewMedia]) {
        dataSource?.reviewData = data
        tiktokTableView.reloadData()
    }
    
    func configureDataWhenLoadMore(_ tiktokModel: [TikTokModel], _ reviewData: [ReviewMedia]) {
        dataSource?.configureWhenLoadMore(tiktokModel: tiktokModel, reviewData: reviewData)
        tiktokTableView.reloadData()
    }
}

//MARK: -  auto play video
extension TikTokScreenViewController {
    func pausePlayeVideos(){
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tiktokTableView)
    }
    
    @objc func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tiktokTableView, appEnteredFromBackground: true)
    }
}
