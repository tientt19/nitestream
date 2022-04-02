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

let parameter : Parameters = [
    "category": 2,
    "contentId": "8550",
    "episodeId": 39173,
    "definition": "GROOT_LD"
]

class APIService:NSObject {
    static let shared: APIService = APIService()
    
    //Handle requestJSON task
    
    //MARK: -  get Data alamonfire
    /// get place datas
    /// - Parameter closure: closure to respone place data results
    func getPlaceData(numberOfPage : Int, closure: @escaping (_ response: [MainModel]?, _ error: Error?) -> Void) {
        var listUsers : [MainModel] = [MainModel]()
        AF.request(Contants.getAPIHttps(numberOfPage), method: .get, headers: HTTPAdditionalHeaders).responseJSON { response in
            if let result = response.value as? [[String:Any]] {
                for item in result {
                    let itemUsers = MainModel()
                    listUsers.append(itemUsers.initLoad(item))
                }
                closure(listUsers,nil)
            }
        }
    }
    
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
    func getReviewMedia(by page: Int, closure: @escaping (_ response: [MediaInfo]?, _ error: Error?) -> Void) {
        var mediaInfo = [MediaInfo]()
        AF.request(Contants.getReviewMedia(with: page), method: .get, headers: HTTPAdditionalHeadersReviewMedia).responseJSON { response in
            if let result = response.value as? [String:Any] {
                dLogDebug(result)
                if let dataItem = result["data"] as? [[String:Any]] {
                    for item in dataItem {
                        mediaInfo.append(MediaInfo(fromDictionary: item))
                    }
                }
                closure(mediaInfo,nil)
            }
        }
    }
}

extension APIService {
    func getTikTokMedia() {
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "[\n  {\n    \"category\": 2,\n    \"contentId\": \"8550\",\n    \"episodeId\": 39173,\n    \"definition\": \"GROOT_LD\"\n  },\n  {\n    \"category\": 2,\n    \"contentId\": \"8551\",\n    \"episodeId\": 39177,\n    \"definition\": \"GROOT_LD\"\n  },\n  {\n    \"category\": 2,\n    \"contentId\": \"8552\",\n    \"episodeId\": 39181,\n    \"definition\": \"GROOT_LD\"\n  }\n]"
        
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://ga-mobile-api.loklok.tv/cms/app/media/bathGetplayInfo")!,timeoutInterval: Double.infinity)
        
        request.headers = HTTPAdditionalHeaders
        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    
}
