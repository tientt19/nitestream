//
//  
//  SearchingIGListKitScreenInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/05/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol SearchingIGListKitScreenInteractorInputProtocol {
    func onHandleGetData()

}

// MARK: - Interactor Output Protocol
protocol SearchingIGListKitScreenInteractorOutputProtocol: AnyObject {
    func onHandleGetDataFinish(with data: [TopSearchData])
}

// MARK: - SearchingIGListKitScreen InteractorInput
class SearchingIGListKitScreenInteractorInput {
    weak var output: SearchingIGListKitScreenInteractorOutputProtocol?
}

// MARK: - SearchingIGListKitScreen InteractorInputProtocol
extension SearchingIGListKitScreenInteractorInput: SearchingIGListKitScreenInteractorInputProtocol {
    func onHandleGetData() {
        DataManager.shared.getSearchingData { response in
            if let data = response {
                DispatchQueue.main.async {
                    self.output?.onHandleGetDataFinish(with: data)
                }
            }
        }
    }
}
