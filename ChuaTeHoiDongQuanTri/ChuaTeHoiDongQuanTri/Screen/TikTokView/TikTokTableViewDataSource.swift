//
//  TikTokTableViewDataSource.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/04/2022.
//

import Foundation
import UIKit

class TikTokTableViewDataSource : TableViewDataSource {
    
    var entities = [TikTokModel]()
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
        return cell
    }
    
    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        
    }
}
