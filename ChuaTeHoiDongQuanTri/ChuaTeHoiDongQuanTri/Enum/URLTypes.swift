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
    case bannerHomePage
    case homePage(Int?)
    case shortVideoURL
    case reviewShortVideo(Int?)
    case niteStreamNew(Int?)
    case niteStreamArticle(Int?)
    
    var path: String {
        switch self {
        case .homePage(let page):
            return "https://web-api.netpop.app/cms/web/pc/homePage/singleAlbums?page=\(page ?? 0)&size=6"
        case .bannerHomePage:
            return "https://web-api.netpop.app/cms/web/pc/homePage/banners?size=10"
        case .shortVideoURL:
            return "https://ga-mobile-api.loklok.tv/cms/app/media/bathGetplayInfo"
        case .reviewShortVideo(let page):
            return "https://ga-mobile-api.loklok.tv/cms/app/recommendPool/getVideoFromRecommondPool?page=\(page ?? 0)"
        case .niteStreamNew(let page):
            return "https://web-api.netpop.app/cms/web/pc/news/list?page=\(page ?? 0)&size=9"
        case .niteStreamArticle(let id):
            return "https://loklok.com/vi/article/\(id ?? 0)"
        }
    }
}
