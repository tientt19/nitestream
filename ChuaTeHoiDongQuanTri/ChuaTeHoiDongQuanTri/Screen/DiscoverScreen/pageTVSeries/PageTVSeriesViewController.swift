//
//  
//  PageTVSeriesViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol PageTVSeriesViewProtocol: AnyObject {
    func reloadData()
}

// MARK: - PageTVSeries ViewController
class PageTVSeriesViewController: BaseViewController {
    var router: PageTVSeriesRouterProtocol!
    var viewModel: PageTVSeriesViewModelProtocol!
    
    @IBOutlet weak var atabileView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
        self.viewModel.getAdvancedSearchResult()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.atabileView.registerCell(nibName: DiscoveryTableViewCell.self)
        self.atabileView.registerCell(nibName: ListSearchResultTableViewCell.self)
        self.atabileView.delegate = self
        self.atabileView.dataSource = self
        self.atabileView.separatorStyle = .none
        self.atabileView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Action
}

// MARK: - UITableViewDelegate
extension PageTVSeriesViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension PageTVSeriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.numberOfCell
        case 1:
            return viewModel.numberOListResult
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeue(cellClass: DiscoveryTableViewCell.self, forIndexPath: indexPath)
            cell.model = viewModel.itemForRow(at: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeue(cellClass: ListSearchResultTableViewCell.self, forIndexPath: indexPath)
            cell.model = viewModel.itemForRow(at: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - PageTVSeries ViewProtocol
extension PageTVSeriesViewController: PageTVSeriesViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.stopLoadingAnimate()
            self.atabileView.reloadData()
        }
    }
}
