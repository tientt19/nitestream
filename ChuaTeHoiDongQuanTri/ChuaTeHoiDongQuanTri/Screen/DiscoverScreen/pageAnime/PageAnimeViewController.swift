//
//  
//  PageAnimeViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol PageAnimeViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    func reloadData()
}

// MARK: - PageAnime ViewController
class PageAnimeViewController: BaseViewController {
    var router: PageAnimeRouterProtocol!
    var viewModel: PageAnimeViewModelProtocol!
    
    @IBOutlet weak var pageAnimeTableView : UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
        self.viewModel.onViewDidLoad()
        self.viewModel.getAdvancedSearchResult()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.pageAnimeTableView.registerCell(nibName: DiscoveryTableViewCell.self)
        self.pageAnimeTableView.registerCell(nibName: ListSearchResultTableViewCell.self)
        self.pageAnimeTableView.delegate = self
        self.pageAnimeTableView.dataSource = self
        self.pageAnimeTableView.separatorStyle = .none
        self.pageAnimeTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Action
    
}

// MARK: - UITableViewDelegate
extension PageAnimeViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension PageAnimeViewController: UITableViewDataSource {
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


// MARK: - PageAnime ViewProtocol
extension PageAnimeViewController: PageAnimeViewProtocol {
    func showHud() {
    }
    
    func hideHud() {
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.stopLoadingAnimate()
            self.pageAnimeTableView.reloadData()
        }
    }
}
