//
//  APIService.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 19/02/2022.
//

import Foundation
import Alamofire

let HTTPAdditionalHeaders : HTTPHeaders = [
    "lang" : "en",
    "versioncode" : "11",
    "clienttype" : "ios_jike_default",
    "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
    "Content-Type" : "application/json",
    "Accept" : "application/json"
]

let HTTPAdditionalHeadersReviewMedia : HTTPHeaders = [
    "lang" : "en",
    "versioncode" : "11",
    "clienttype" : "ios_jike_default",
    "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
    "deviceid" : ""
]

class APIService:NSObject {
    static let shared: APIService = APIService()
    
    //Handle requestJSON task
    
    func getHomeData(numberOfPage : Int, closure: @escaping (_ response: HomePageModel?, _ error: Error?) -> Void) {
        var listDataHome : HomePageModel = HomePageModel(fromDictionary: ["" : ""])
        AF.request(Contants.getDataHomeHTTPs(numberOfPage), method: .get, headers: HTTPAdditionalHeaders).responseJSON { response in
            if let result = response.value as? [String:Any] {
                if let dataItem = result["data"] as? [String:Any] {
                    let item = HomePageModel(fromDictionary: dataItem)
                    listDataHome = item
                }
                closure(listDataHome,nil)
            }
        }
    }
    
    func getTopSearchData(closure: @escaping (_ response: [TopSearchData]?, _ error: Error?) -> Void) {
        var listTopSearch : [TopSearchData] = [TopSearchData]()
        AF.request(Contants.getDataTopSearchHTTPS(), method: .get, headers: HTTPAdditionalHeaders).responseJSON { response in
            if let result = response.value as? [String:Any] {
                if let dataItem = result["data"] as? [String:Any] {
                    if let list = dataItem["list"] as? [[String: Any]] {
                        for item in list {
                            let dataTemp = TopSearchData(fromDictionary: item)
                            listTopSearch.append(dataTemp)
                        }
                    }
                }
                closure(listTopSearch,nil)
            }
        }
    }
}

//MARK: - Get movie Detail

extension APIService {
    func getMovieDetail(id : Int, category : Int, closure: @escaping (_ response: MovieDetail?, _ error: Error?) -> Void) {
        var movieDetail = MovieDetail(fromDictionary: ["" : ""])
        AF.request(Contants.getMovieDetail(id, category), method: .get, headers: HTTPAdditionalHeaders).responseJSON { response in
            if let result = response.value as? [String:Any] {
                if let dataItem = result["data"] as? [String:Any] {
                    movieDetail = MovieDetail(fromDictionary: dataItem)
                }
                closure(movieDetail,nil)
            }
        }
    }
}

//MARK: - Get Link Media

extension APIService {
    func getLinkMedia(contentId : String, categoty : Int, episodeId : Int, definition : String, closure: @escaping (_ response: LinkMedia?, _ error: Error?) -> Void) {
        var linkMedia = LinkMedia(fromDictionary: ["" : ""])
        AF.request(Contants.getLinkMedia(categoty, contentId, episodeId, definition), method: .get, headers: HTTPAdditionalHeaders).responseJSON { response in
            if let result = response.value as? [String:Any] {
                if let dataItem = result["data"] as? [String:Any] {
                    linkMedia = LinkMedia(fromDictionary: dataItem)
                }
                closure(linkMedia,nil)
            }
        }
    }
}


//MARK: -- Get Review Media

extension APIService {
    func getReviewMedia(by page: Int, closure: @escaping (_ response: [ReviewMedia]?, _ error: Error?) -> Void) {
        var mediaInfo = [ReviewMedia]()
        AF.request(Contants.getReviewMedia(with: page), method: .get, headers: HTTPAdditionalHeadersReviewMedia).responseJSON { response in
            if let result = response.value as? [String:Any] {
                if let dataItem = result["data"] as? [[String:Any]] {
                    for item in dataItem {
                        mediaInfo.append(ReviewMedia(fromDictionary: item))
                    }
                }
                closure(mediaInfo,nil)
            }
        }
    }
}

extension APIService {
    func getTikTokMedia(with rawBody : String, completion: @escaping (_ response: [TikTokModel]?, _ error: Error?) -> Void) {
        var semaphore = DispatchSemaphore (value: 0)
        var tikTokModelDAO = [TikTokModel]()
        let parameters = rawBody
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: Contants.getReviewMedia())!,timeoutInterval: Double.infinity)
        
        request.headers = HTTPAdditionalHeaders
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data else {
                semaphore.signal()
                completion(nil, error)
                return
            }
            
            let itemData = String(data: data, encoding: .utf8)!
            if let output = convertToDictionary(text: itemData) {
                if let dataItem = output["data"] as? [[String:Any]] {
                    for item in dataItem {
                        tikTokModelDAO.append(TikTokModel(fromDictionary: item))
                    }
                    semaphore.signal()
                }
            }
        }
        task.resume()
        semaphore.wait()
        completion(tikTokModelDAO, nil)
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

// MARK: - Get Discovery
extension APIService {
    func getDiscoveryItem(closure: @escaping (_ response: [DiscoveryModel]?, _ error: Error?) -> Void) {
        var discoveryData = [DiscoveryModel]()
        AF.request(Contants.discoverySearch, method: .get, headers: HTTPAdditionalHeaders).responseJSON { response in
            if let result = response.value as? [String:Any] {
                if let dataItem = result["data"] as? [[String:Any]] {
                    for item in dataItem {
                        let dataTemp = DiscoveryModel(item)
                        discoveryData.append(dataTemp)
                    }
                }
                closure(discoveryData,nil)
            }
        }
    }
}

//MARK: - Get search data
extension APIService {
    func searchLenovo(with keyWord : String, closure: @escaping (_ response: [String]?, _ error: Error?) -> Void) {
        var searchingResultDAO = [String]()
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\n    \"searchKeyWord\": \"\(keyWord)\",\n    \"size\": 20\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: Contants.searchlenovo)!,timeoutInterval: Double.infinity)
        request.headers = HTTPAdditionalHeaders
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
                closure(nil,error)
                return
            }
            
            let itemData = String(data: data, encoding: .utf8)!
            if let output = self.convertToDictionary(text: itemData) {
                if let dataItem = output["data"] as? [String:Any] {
                    if let data = dataItem["searchResults"] as? [String] {
                        for item in data {
                            searchingResultDAO.append(item)
                        }
                        semaphore.signal()
                    }
                }
            }
        }
        task.resume()
        semaphore.wait()
        closure(searchingResultDAO, nil)
    }
    
    func getSearchingResult(with keyWord : String, closure: @escaping (_ response: [SearchResult]?, _ error: Error?) -> Void) {
        var searchingResultDAO = [SearchResult]()
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\n    \"searchKeyWord\": \"\(keyWord)\",\n    \"size\": 50,\n    \"sort\": \"\",\n    \"searchType\": \"\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: Contants.getSearchingData())!,timeoutInterval: Double.infinity)
        request.headers = HTTPAdditionalHeaders
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
                closure(nil,error)
                return
            }
            
            let itemData = String(data: data, encoding: .utf8)!
            if let output = self.convertToDictionary(text: itemData) {
                if let dataItem = output["data"] as? [String:Any] {
                    if let data = dataItem["searchResults"] as? [[String:Any]] {
                        for item in data {
                            let dataTemp = SearchResult(fromDictionary: item)
                            searchingResultDAO.append(dataTemp)
                        }
                        semaphore.signal()
                    }
                }
            }
        }
        task.resume()
        semaphore.wait()
        closure(searchingResultDAO, nil)
    }
    
    func getAdvancedSearching(params : String? = "",
                              area : String? = "",
                              category : String? = "",
                              year : String? = "",
                              subtitles : String? = "",
                              order : String? = "",
                              closure: @escaping (_ response: [SearchResult]?, _ error: Error?) -> Void) {
        
        var searchingResultDAO = [SearchResult]()
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\n    \"size\": 50,\n    \"params\": \"\(params ?? "")\",\n    \"area\": \"\(area ?? "")\",\n    \"category\": \"\(category ?? "")\",\n    \"year\": \"\(year ?? "")\",\n    \"subtitles\": \"\(subtitles ?? "")\",\n    \"order\": \"\(order ?? "up")\"\n}"
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: Contants.advancedSearch)!,timeoutInterval: Double.infinity)
        request.headers = HTTPAdditionalHeaders
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
                closure(nil,error)
                return
            }
            
            let itemData = String(data: data, encoding: .utf8)!
            if let output = self.convertToDictionary(text: itemData) {
                if let dataItem = output["data"] as? [String:Any] {
                    if let data = dataItem["searchResults"] as? [[String:Any]] {
                        for item in data {
                            let dataTemp = SearchResult(fromDictionary: item)
                            searchingResultDAO.append(dataTemp)
                        }
                        semaphore.signal()
                    }
                }
            }
        }
        task.resume()
        semaphore.wait()
        closure(searchingResultDAO, nil)
    }
}


