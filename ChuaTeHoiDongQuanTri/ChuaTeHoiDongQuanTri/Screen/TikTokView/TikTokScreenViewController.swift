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
    }
    
    func setupView() {
        dataSource = TikTokTableViewDataSource(entities: tempData, with: presenter!)
        tiktokTableView.registerCell(nibName: tiktokTableViewCell.self)
    }
}

//MARK: - UITableViewDataSource
extension TikTokScreenViewController : UITableViewDataSource {
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
        dataSource?.endDisplayCell(tableView, didEndDisplaying: cell, forRowAt: indexPath)
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
