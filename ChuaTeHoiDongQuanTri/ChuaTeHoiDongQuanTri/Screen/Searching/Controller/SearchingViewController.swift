//
//  SearchingViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import UIKit

class SearchingViewController: BaseViewController {
    
    @IBOutlet weak var topSearchTableView : UITableView!
    
    var topSearchData = [TopSearchData]()
    var presenter : SearchingPresenterProtocols?
    internal var tableViewDataSource : TableViewDataSource?
    
    lazy var textFieldView : UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)!, height: 30))
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Searching"
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPView()
        presenter?.callToGetTopSearchingData()
    }
}

extension SearchingViewController {
    func setUPView() {
        setUpBaseView()
        hideKeyboardWhenTappedAround()
        navigationItem.titleView = textFieldView
        topSearchTableView.registerCell(nibName: TopSearchTableViewCell.self)
    }
}
//MARK: - UITableViewDelegate
extension SearchingViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewDataSource?.didSelect(tableView: tableView, indexPath: indexPath)
    }

}
//MARK: - UITableViewDataSource
extension SearchingViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewDataSource?.itemCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 24))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: 24)
        label.text = "Tìm kiếm hàng đầu"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return topSearchTableView.frame.height / 8
    }
}

//MARK: - SearchingViewProtocols
extension SearchingViewController : SearchingViewProtocols {
    func reloadTableView(tableViewDataSource: TableViewDataSource) {
        self.tableViewDataSource = tableViewDataSource
        stopLoadingAnimate()
        topSearchTableView.reloadData()
    }
}
