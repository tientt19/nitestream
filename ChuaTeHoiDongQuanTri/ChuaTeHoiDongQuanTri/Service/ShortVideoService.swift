//
//  ShortVideoService.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 30/05/2022.
//

import Foundation

protocol ShortVideoServiceProtocols: AnyObject {
    func onGetRawBody(with data : [ReviewShortVideoModel]) -> String
    func onGetShortVideo(with rawBody: String, completion: @escaping (_ response: [ShortVideoModel]?, _ error: Error?) -> Void)
    func onGetReviewShortVideo(with page: Int?, completion: @escaping ((Result<BaseModel<[ReviewShortVideoModel]>, APIError>) -> Void))
}

//MARK: - ShortVideoServiceProtocols
class ShortVideoService: ShortVideoServiceProtocols {
    private let service = BaseService.shared
    
    /// get tik tok video
    /// - Parameters:
    ///   - rawBody: paras
    ///   - completion: result
    func onGetShortVideo(with rawBody: String, completion: @escaping (_ response: [ShortVideoModel]?, _ error: Error?) -> Void) {
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = rawBody
        let postData = parameters.data(using: .utf8)
        var tikTokModelDAO = [ShortVideoModel]()
        var request = URLRequest(url: URL(string: URLTypes.shortVideoURL.path)!, timeoutInterval: Double.infinity)

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
            if let output = self.convertToDictionary(text: itemData) {
                if let dataItem = output["data"] as? [[String:Any]] {
                    for item in dataItem {
                        tikTokModelDAO.append(ShortVideoModel(fromDictionary: item))
                    }
                    semaphore.signal()
                }
            }
        }
        task.resume()
        semaphore.wait()
        completion(tikTokModelDAO, nil)
    }
    
    func onGetReviewShortVideo(with page: Int?, completion: @escaping ((Result<BaseModel<[ReviewShortVideoModel]>, APIError>) -> Void)) {
        let url = URLTypes.reviewShortVideo(page).path
        self.service.GET(url: url,
                         param: nil,
                         completion: completion)
    }
    
    func onGetRawBody(with data: [ReviewShortVideoModel]) -> String {
        return "[\n  {\n    \"category\": \(String(describing: data[0].category ?? 0)),\n    \"contentId\": \"\(String(describing: data[0].id ?? ""))\",\n    \"episodeId\": \(String(describing: data[0].mediaInfo?.id ?? 0)),\n    \"definition\": \"\(String(describing: data[0].mediaInfo?.definitionList?.first?.code ?? ""))\"\n  }\n]"
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
