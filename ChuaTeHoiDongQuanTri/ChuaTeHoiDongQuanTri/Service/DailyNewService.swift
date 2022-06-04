//
//  DailyNewService.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//

import Foundation

protocol DailyNewsServiceProtocols: AnyObject {
    func onGetListDailyNews(with page: Int?, completion: @escaping ((Result<BaseModel<DailyNewsModel>, APIError>) -> Void))
}

//MARK: - DailyNewsServiceProtocols
class DailyNewsService: DailyNewsServiceProtocols {
    private let service = BaseService.shared
    
    func onGetListDailyNews(with page: Int?, completion: @escaping ((Result<BaseModel<DailyNewsModel>, APIError>) -> Void)) {
        self.service.GET(url: URLTypes.niteStreamNew(page).path,
                         param: nil,
                         completion: completion)
    }
    
}
