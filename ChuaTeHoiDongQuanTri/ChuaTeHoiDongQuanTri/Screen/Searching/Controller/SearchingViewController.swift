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
    
    lazy var textFieldView : UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)!, height: 30))
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Thách chúng mày search"
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
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.openDetailView(id: topSearchData[indexPath.row].id, category: topSearchData[indexPath.row].domainType)
    }

}
//MARK: - UITableViewDataSource
extension SearchingViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topSearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: TopSearchTableViewCell.self, forIndexPath: indexPath)
        let imageURL = topSearchData[indexPath.row].cover ?? ""
        let name = topSearchData[indexPath.row].title ?? ""
        cell.configure(imageURL, name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tìm Kiếm Hàng Đầu"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return topSearchTableView.frame.height / 8
    }
}

//MARK: - SearchingViewProtocols
extension SearchingViewController : SearchingViewProtocols {
    func reloadTableView(with data : [TopSearchData]) {
        self.topSearchData = data
        stopLoadingAnimate()
        topSearchTableView.reloadData()
    }
}
