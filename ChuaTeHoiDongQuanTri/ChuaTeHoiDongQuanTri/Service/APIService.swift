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
    "clienttype" : "ios_jike_default"
]

let testPara : [String : Any] = [
    "category": 2,
    "contentId": "5959",
    "episodeId": 29804,
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
    
//    func testPost() {
//        AF.request("https://ga-mobile-api.loklok.tv/cms/app/media/bathGetplayInfo", method: .post, parameters: testPara,encoding: JSONEncoding.default, headers: HTTPAdditionalHeaders).responseJSON { response in
//            if let result = response.value as? [String:Any] {
//               dLogDebug(response)
//            }
//        }
//    }
}


//MARK: - Extension

extension String {
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}

extension Dictionary {
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            if value is String {
                let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
                return "\(percentEscapedKey)=\(percentEscapedValue)"
            }
            else {
                return "\(percentEscapedKey)=\(value)"
            }
        }
        return parameterArray.joined(separator: "&")
    }
}
