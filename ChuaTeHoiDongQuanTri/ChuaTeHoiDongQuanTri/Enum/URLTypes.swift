//
//  URLTypes.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 30/05/2022.
//

import Foundation

// MARK: ApiUrlProtocol
protocol ApiUrlProtocol {
    var path: String { get }
}

enum URLTypes: ApiUrlProtocol {
    case shortVideoURL
    case reviewShortVideo(Int?)
    
    var path: String {
        switch self {
        case .shortVideoURL:
            return "https://ga-mobile-api.loklok.tv/cms/app/media/bathGetplayInfo"
        case .reviewShortVideo(let page):
            return "https://ga-mobile-api.loklok.tv/cms/app/recommendPool/getVideoFromRecommondPool?page=\(page ?? 0)"
        }
    }
}
