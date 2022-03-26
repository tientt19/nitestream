//
//  ExpandViewControler.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 26/03/2022.
//

import UIKit

class ExpandViewControler: UIViewController {
    
    var listMoviePassed = RecommendItem(fromDictionary: ["" : ""])
    @IBOutlet weak var expandCollectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    init(data : RecommendItem) {
        self.listMoviePassed = data
        super.init(nibName: nil , bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExpandViewControler {
    func setupView() {
        navigationItem.title = listMoviePassed.homeSectionName
        expandCollectionView.registerCell(nibName: MovieCell.self)
        expandCollectionView.reloadData()
    }
}

extension ExpandViewControler: UICollectionViewDelegate {
    
}

extension ExpandViewControler: UICollectionViewDataSource {
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

extension ExpandViewControler: UICollectionViewDelegateFlowLayout {
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
