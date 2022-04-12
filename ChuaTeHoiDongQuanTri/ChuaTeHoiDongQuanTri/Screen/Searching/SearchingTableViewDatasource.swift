//
//  SearchingTableViewDatasource.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//

import Foundation
import UIKit


final class SearchTableViewDataSource : TableViewDataSource {
 
    private var entities: [TopSearchData]!
    private weak var presenter: SearchingPresenterProtocols?
    var searchingData = [SearchResult]()

    init(entities: [TopSearchData],with  presenter: SearchingPresenterProtocols) {
        self.entities = entities
        self.presenter = presenter
    }

    var numberOfItems: Int {
        return entities.count
    }
    
    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: TopSearchTableViewCell.self, forIndexPath: indexPath)
        let imageURL = entities[indexPath.row].cover ?? ""
        let name = entities[indexPath.row].title ?? ""
        cell.configure(imageURL, name)
        return cell
    }
    
    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.openDetailView(id: entities[indexPath.row].id, category: entities[indexPath.row].domainType)
    }
}
