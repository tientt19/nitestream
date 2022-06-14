//
//  File.swift
//  nitestream
//
//  Created by Valerian on 13/06/2022.
//

import Foundation

enum DiscoveryParams: Int {
    case TVSeries
    case Movie
    case Anime
    
    var toString: String {
        switch self {
        case .TVSeries:
            return "TV,SETI,MINISERIES,VARIETY,TALK,COMIC,DOCUMENTARY"
        case .Movie:
            return "MOVIE,TVSPECIAL"
        case .Anime:
            return "COMIC"
        }
    }
}

enum DiscoveryCategoryParams: Int {
    case area
    case cate
    case year
    case sub
    case order
    
    var toString: String {
        switch self {
        case .area:
            return "Khu vực"
        case .cate:
            return "Thể loại"
        case .year:
            return "Các thời kỳ"
        case .sub:
            return "Tất cả phụ đề"
        case .order:
            return "Mới nhất"
        }
    }
}
