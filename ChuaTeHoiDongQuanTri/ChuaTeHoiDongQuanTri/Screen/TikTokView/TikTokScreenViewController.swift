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
    var storeLink = [TikTokModel]()
    @IBOutlet weak var tiktokTableView : UITableView!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchData(with: 0)
        tiktokTableView.registerCell(nibName: tiktokTableViewCell.self)
    }
}

extension TikTokScreenViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeLink.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: tiktokTableViewCell.self, forIndexPath: indexPath)
        cell.playMedia(link: storeLink[indexPath.row].mediaUrl)
        return cell
    }
}

extension TikTokScreenViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tiktokTableView.frame.height
    }
}

//MARK: - TikTokScreenViewProtocol
extension TikTokScreenViewController: TikTokScreenViewProtocol{

    // TODO: Implement View Output Methods
    func showStreaming(data: [TikTokModel]) {
        self.storeLink = data
        tiktokTableView.reloadData()
    }
}
