//
//  Contants.swift
//  AppWidgetsTest
//
//  Created by Valerian on 30/11/2021.
//

import Foundation

struct Contants {
    static let discoverySearch = "https://ga-mobile-api.loklok.tv/cms/app/search/list"
    static func getAPIHttps(_ numberOfPage: Int) -> String {
        return "https://jsonplaceholder.typicode.com/albums/\(numberOfPage)/photos"
    }
    
    static func getDataHomeHTTPs(_ page : Int) -> String {
        return "https://ga-mobile-api.loklok.tv/cms/app/homePage/getHome?page=\(page)"
    }
    
    static func getDataTopSearchHTTPS() -> String {
        return "https://ga-mobile-api.loklok.tv/cms/app/search/v1/searchLeaderboard"
    }
    
    static func  getMovieDetail(_ id : Int,_ category : Int) -> String {
        return "https://ga-mobile-api.loklok.tv/cms/app/movieDrama/get?id=\(id)&category=\(category)"
    }
    
    static func getLinkMedia(_ category :Int,_ contentId : String,_ episodeId : Int,_ definittion : String) -> String {
        return "https://ga-mobile-api.loklok.tv/cms/app/media/previewInfo?category=\(category)&contentId=\(contentId)&episodeId=\(episodeId)&definition=\(definittion)"
    }
    
    static func getEpisode(_ id : String, _ category : String) -> String {
        return "https://ga-mobile-api.loklok.tv/cms/app/movieDrama/get?id=\(id)&category=\(category)"
    }
    
    static func getReviewMedia(with page : Int) -> String {
        return "https://ga-mobile-api.loklok.tv/cms/app/recommendPool/getVideoFromRecommondPool?page=\(page)"
    }
    
    static func getReviewMedia() -> String {
        return "https://ga-mobile-api.loklok.tv/cms/app/media/bathGetplayInfo"
    }
}
