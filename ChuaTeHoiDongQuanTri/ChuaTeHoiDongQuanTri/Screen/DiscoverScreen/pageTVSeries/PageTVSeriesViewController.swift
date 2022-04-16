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
    func showHud()
    func hideHud()
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
    }
    
    // MARK: - Init
    private func setupInit() {
        self.atabileView.registerCell(nibName: DiscoveryTableViewCell.self)
        self.atabileView.delegate = self
        self.atabileView.dataSource = self
        self.atabileView.separatorStyle = .none
    }
    
    // MARK: - Action
    
}

// MARK: - UITableViewDelegate
extension PageTVSeriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - UITableViewDataSource
extension PageTVSeriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: DiscoveryTableViewCell.self, forIndexPath: indexPath)
        cell.model = viewModel.itemForRow(at: indexPath)
        return cell
    }
}

// MARK: - PageTVSeries ViewProtocol
extension PageTVSeriesViewController: PageTVSeriesViewProtocol {
    func showHud() {
        // show hub
    }
    
    func hideHud() {
        // hide hub
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.atabileView.reloadData()
        }
    }
}
