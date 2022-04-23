//
//  
//  PageMovieViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol PageMovieViewProtocol: AnyObject {
    func reloadData()
}

// MARK: - PageMovie ViewController
class PageMovieViewController: BaseViewController {
    var router: PageMovieRouterProtocol!
    var viewModel: PageMovieViewModelProtocol!
    
    @IBOutlet weak var pageMovieTableView : UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
        self.viewModel.getAdvancedSearchResult()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.pageMovieTableView.registerCell(nibName: DiscoveryTableViewCell.self)
        self.pageMovieTableView.registerCell(nibName: ListSearchResultTableViewCell.self)
        self.pageMovieTableView.delegate = self
        self.pageMovieTableView.dataSource = self
        self.pageMovieTableView.separatorStyle = .none
        self.pageMovieTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Action
    
}

// MARK: - UITableViewDelegate
extension PageMovieViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension PageMovieViewController: UITableViewDataSource {
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

// MARK: - PageMovie ViewProtocol
extension PageMovieViewController: PageMovieViewProtocol {
    func showHud() {
    }
    
    func hideHud() {
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.stopLoadingAnimate()
            self.pageMovieTableView.reloadData()
        }
    }
}
