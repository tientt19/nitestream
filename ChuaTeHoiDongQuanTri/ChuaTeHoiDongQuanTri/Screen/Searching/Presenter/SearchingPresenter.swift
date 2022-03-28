//
//  SearchingPresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import Foundation


class SearchingPresenter : SearchingPresenterProtocols {
    weak var view: SearchingViewProtocols?
    var interactor: SearchingInteratorInputProtocols?
    var router: SearchingRouterProtocols?
}


extension SearchingPresenter : SearchingInteractorOutputProtocols {
    
}
