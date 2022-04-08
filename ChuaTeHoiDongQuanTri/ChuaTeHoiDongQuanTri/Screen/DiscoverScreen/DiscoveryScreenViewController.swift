//
//  
//  DiscoveryScreenViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 05/04/2022.
//
//

import UIKit

class DiscoveryScreenViewController: BaseViewController {

    @IBOutlet weak var atabileView: UITableView!
    var presenter: DiscoveryScreenPresenterProtocol!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.presenter.onViewDidLoad()
    }
    
    // MARK: - Setup
    private func setupInit() {
        self.registerCell()
    }
    
    private func registerCell() {
        self.atabileView.registerCell(nibName: DiscoveryTableViewCell.self)
        self.atabileView.delegate = self
        self.atabileView.dataSource = self
        self.atabileView.separatorStyle = .none
    }
    
    // MARK: - Action
    
}

// MARK: - DiscoveryScreenViewProtocol
extension DiscoveryScreenViewController: DiscoveryScreenViewProtocol {
    
}

// MARK: - UITableViewDelegate
extension DiscoveryScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

// MARK: - UITableViewDataSource
extension DiscoveryScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: DiscoveryTableViewCell.self, forIndexPath: indexPath)
        return cell
    }
}
