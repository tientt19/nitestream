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
