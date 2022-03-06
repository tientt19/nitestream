//
//  ViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 19/02/2022.
//

//import UIKit
//
//class ViewController: BaseViewController {
//    
//    var presenter : MainPresenter!
//        
//    @IBOutlet weak var mainCollectionView : UICollectionView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpView()
//    }
//}
//
//extension ViewController {
//    func setUpView() {
//        setUpBaseView()
//        
//        presenter = MainPresenter(view: self)
//        presenter.getData(page: 15)
//        
//        mainCollectionView.registerCell(nibName: MainCell.self)
//
//        if let layout = mainCollectionView?.collectionViewLayout as? PinterestLayout {
//          layout.delegate = self
//        }
//        
//        mainCollectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
//
//    }
//}
//
//extension ViewController: UICollectionViewDelegate {
//    
//}
//
//extension ViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return presenter.listData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeue(cellClass: MainCell.self, forIndexPath: indexPath)
//        cell.configure(presenter.getListPhoto()[indexPath.row])
//        return cell
//    }
//}
//
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let itemSize = (mainCollectionView.frame.width - (mainCollectionView.contentInset.left + mainCollectionView.contentInset.right + 10)) / 2
//      return CGSize(width: itemSize, height: itemSize)
//    }
//}
//
//extension ViewController: PinterestLayoutDelegate {
//    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
//        return imageDimenssions(url: presenter.getListPhoto()[indexPath.row].url) + CGFloat((indexPath.item * Int.random(in: 1...10)))
//    }
//}
//
//extension ViewController: UpdateMainDelegate {
//    func updateUI() {
//        DispatchQueue.main.async { [weak self] in
//            guard let _self = self else { return }
//            _self.stopLoadingAnimate()
//            _self.mainCollectionView.reloadData()
//        }
//    }
//}
//
//func imageDimenssions(url: String) -> CGFloat{
//    if let imageSource = CGImageSourceCreateWithURL(URL(string: url)! as CFURL, nil) {
//        if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
////            let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
//            let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
//            return CGFloat(pixelHeight / 3)
//        }
//    }
//    return 0
//}
//
