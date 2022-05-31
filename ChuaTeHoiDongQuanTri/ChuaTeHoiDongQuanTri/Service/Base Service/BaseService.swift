//
//  BaseService.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 30/05/2022.
//

import Alamofire

class BaseService {
    static let shared = BaseService()
    
    private var headers : HTTPHeaders = [
        "lang" : "en",
        "versioncode" : "11",
        "clienttype" : "ios_jike_default",
        "deviceid": ""
//        "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
//        "Content-Type" : "application/json",
//        "Accept" : "application/json"
    ]
    
    // MARK: - JSONDecoder
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
//        let dateFormat = DateFormatter()
//        decoder.dateDecodingStrategy = .formatted(dateFormat)
        return decoder
    }
    
    // MARK: - GET
    func GET<T: Codable>(url: String,
                         param: [String: Any]?,
                         completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        let request = AF.request(url,
                                 method: .get,
                                 parameters: param,
                                 headers: self.headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
                      
            guard let `self` = self else { return }
            
            completion(self.handleResponse(response))
        }
    }
    
    // MARK: - POST
    func POST<T: Codable>(url: String,
                          param: [String: Any]?,
                          encoding: ParameterEncoding = URLEncoding.default,
                          completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        let request = AF.request(url,
                                 method: .post,
                                 parameters: param,
                                 encoding: encoding,
                                 headers: headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    // MARK: - Handle Response
    func handleResponse<T: Codable>(_ response: DataResponse<T, AFError>) -> (Result<T, APIError>) {
        switch response.result {
        case .success(let value):
            return Result.success(value)
            
        case .failure(let error):
            guard let data = response.data else {
                let code = response.response?.statusCode ?? -1
//                if code == 401 {
//                    self.handlerTokenExpire()
//                }
                let message =  error.errorDescription ?? "AFError"
                let apiError = APIError(message: message, statusCode: code)
                return Result.failure(apiError)
            }
            
            if let apiError = try? self.jsonDecoder.decode(APIError.self, from: data) {
                return Result.failure(apiError)
                
            } else {
                let code = response.response?.statusCode ?? -1
//                if code == 401 {
//                    self.handlerTokenExpire()
//                }
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                let metaObject = jsonObject?["meta"] as? [String: Any]
                let messageData = metaObject?["message"] as? String
                
                let message = messageData ?? error.errorDescription ?? "AFError"
                let apiError = APIError(message: message, statusCode: code)
                return Result.failure(apiError)
            }
        }
    }
}
