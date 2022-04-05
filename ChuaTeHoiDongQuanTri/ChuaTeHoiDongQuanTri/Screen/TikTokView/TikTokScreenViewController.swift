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
    var presenter: TikTokScreenPresenterProtocol?
    var dataSource : TableViewDataSource?
    
    @IBOutlet weak var tiktokTableView : UITableView!
    @IBOutlet weak var posterImamge : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var tagListView : TagListView!
    
    var reviewData = [ReviewMedia]()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.fetchData(with: 0)
    }
    
    func setupView() {
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
        configure(data: reviewData[indexPath.row])
        return cell!
    }
}

//MARK: - UITableViewDelegate
extension TikTokScreenViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tiktokTableView.frame.height
    }
}

//MARK: - TikTokScreenViewProtocol
extension TikTokScreenViewController: TikTokScreenViewProtocol{

    // TODO: Implement View Output Methods
    func showStreaming(data: [TikTokModel]) {
        dataSource = TikTokTableViewDataSource(entities: data, with: presenter!)
        tiktokTableView.reloadData()
    }
    
    func configureView(data: [ReviewMedia]) {
        reviewData = data
    }
    
    func configure(data : ReviewMedia) {
        posterImamge.setImageCachingv2(targetImageView: posterImamge, with: data.refList[0].coverVerticalUrl)
        titleLabel.text = data.introduction
        scoreLabel.text = "\(String(describing: data.refList[0].score ?? 0))"
        tagListView.textFont = UIFont.systemFont(ofSize: 12)
        tagListView.addTags(data.refList[0].tagList.map { $0.name })
    }

}
