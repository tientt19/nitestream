//
//  ExpandScreenViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 29/03/2022.
//  
//

import UIKit
import CoreAudio

class ExpandScreenViewController: UIViewController {
    // MARK: - Properties
    var presenter: ExpandScreenPresenterProtocol?
    var listMoviePassed = RecommendItem(fromDictionary: ["" : ""])
    @IBOutlet weak var expandCollectionView : UICollectionView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension ExpandScreenViewController {
    
    //MARK: - set up view
    func setupView() {
        navigationItem.title = listMoviePassed.homeSectionName
        expandCollectionView.registerCell(nibName: MovieCell.self)
        expandCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSourcePrefetching
extension ExpandScreenViewController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let imageUrl = listMoviePassed.recommendContentVOList[indexPath.row].imageUrl, let titleLabel = listMoviePassed.recommendContentVOList[indexPath.row].title {
                let cell = collectionView.cellForItem(at: indexPath) as? MovieCell
                cell?.configure(imageUrl, titleLabel)
            }
        }
    }
}

//MARK: - UICollectionViewDelegate
extension ExpandScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.openDetailView(id: listMoviePassed.recommendContentVOList[indexPath.row].id, category: listMoviePassed.recommendContentVOList[indexPath.row].category)
    }
}

//MARK: - UICollectionViewDataSource
extension ExpandScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMoviePassed.recommendContentVOList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let imageUrl = listMoviePassed.recommendContentVOList[indexPath.row].imageUrl, let titleLabel = listMoviePassed.recommendContentVOList[indexPath.row].title {
            let cell = collectionView.dequeue(cellClass: MovieCell.self, forIndexPath: indexPath)
            cell.configure(imageUrl, titleLabel)
            return cell
        }
        return UICollectionViewCell()
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension ExpandScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widther = expandCollectionView.frame.width / 3
        let heigher = widther * 7 / 5
        return CGSize(width: widther - 10, height: heigher + 30)
    }
}

//MARK: - ExpandScreenViewProtocol
extension ExpandScreenViewController: ExpandScreenViewProtocol{
    // TODO: Implement View Output Methods
}


