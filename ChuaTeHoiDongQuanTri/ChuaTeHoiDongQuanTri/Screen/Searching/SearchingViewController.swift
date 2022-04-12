//
//  SearchingViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import UIKit

class SearchingViewController: BaseViewController {
    
    @IBOutlet weak var topSearchTableView : UITableView!
    @IBOutlet weak var searchingTableView : UITableView!
    
    var searchingData = [String]()
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
        searchingTableView.estimatedRowHeight = 50
        topSearchTableView.registerCell(nibName: TopSearchTableViewCell.self)
        searchingTableView.registerCell(nibName: SearchingCell.self)
        navigationItem.titleView = textFieldView
        textFieldView.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            activityIndicatorView.startAnimating()
            presenter?.callToGetTopSearchingData()
        }
        if let searchKey = textField.text {
            presenter?.handleSearchWithKeywork(searchKey)
        }
    }
}
//MARK: - UITableViewDelegate
extension SearchingViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case topSearchTableView:
            tableViewDataSource?.didSelect(tableView: tableView, indexPath: indexPath)
        case searchingTableView:
            textFieldView.text = searchingData[indexPath.row].htmlToString
            presenter?.getListSearch(searchingData[indexPath.row])
        default:
            break
        }
    }
}
//MARK: - UITableViewDataSource
extension SearchingViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case topSearchTableView:
            return tableViewDataSource?.numberOfItems ?? 0
        case searchingTableView:
            return self.searchingData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case topSearchTableView:
            return tableViewDataSource?.itemCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
        case searchingTableView:
            let cell = tableView.dequeue(cellClass: SearchingCell.self, forIndexPath: indexPath)
            cell.searchResultLabel.text = searchingData[indexPath.row].htmlToString
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == topSearchTableView {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 24))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: 24)
            label.text = "Tìm kiếm hàng đầu"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .black
            
            headerView.addSubview(label)
            
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case topSearchTableView:
            return topSearchTableView.frame.height / 8
        case searchingTableView:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
}

//MARK: - SearchingViewProtocols
extension SearchingViewController : SearchingViewProtocols {
    func reloadSearchingTableView(_ data: [String]) {
        if data.isEmpty {
            stopLoadingAnimate()
            searchingTableView.isHidden = true
        } else {
            self.searchingData = data
            stopLoadingAnimate()
            searchingTableView.isHidden = false
            searchingTableView.reloadData()
        }
    }
    
    func reloadTableView(tableViewDataSource: TableViewDataSource) {
        self.tableViewDataSource = tableViewDataSource
        searchingTableView.isHidden = true
        stopLoadingAnimate()
        topSearchTableView.reloadData()
    }
}
