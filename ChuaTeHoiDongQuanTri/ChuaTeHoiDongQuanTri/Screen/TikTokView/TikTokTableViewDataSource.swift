//
//  TikTokTableViewDataSource.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/04/2022.
//

import Foundation
import UIKit

class TikTokTableViewDataSource : TikTokDataSourceProtocols {

    var entities = [TikTokModel]()
    var reviewData = [ReviewMedia]()
    private weak var presenter: TikTokScreenPresenterProtocol?
    
    init(entities: [TikTokModel],with  presenter: TikTokScreenPresenterProtocol) {
        self.entities = entities
        self.presenter = presenter
    }
    
    var numberOfItems: Int {
        return entities.count 
    }
    
    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: tiktokTableViewCell.self, forIndexPath: indexPath)
        cell.playMedia(link: entities[indexPath.row].mediaUrl)
        cell.configure(data: reviewData[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func configureWhenLoadMore(tiktokModel: [TikTokModel], reviewData: [ReviewMedia]) {
        entities += tiktokModel
        self.reviewData += reviewData
    }
    
    func endDisplayCell(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let endCellDisplay = tableView.cellForRow(at: indexPath) as? tiktokTableViewCell {
//            endCellDisplay.moviePlayer.pause()
//        }
    }

    func didSelect(tableView: UITableView, indexPath: IndexPath) { }
    
    func loadMore(with page: Int) {
        presenter?.loadMore(with: page)
    }
}

extension TikTokTableViewDataSource : openDetailMovieProtocol {
    func getMovieDetail(index: Int) {
        presenter?.openDetail(with: entities[index].episodeId, and: entities[index].businessType)
    }
}
