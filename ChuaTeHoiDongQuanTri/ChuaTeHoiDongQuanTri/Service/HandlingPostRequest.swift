//
//  HandlingPostRequest.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 06/03/2022.
//

import Foundation

class HandlingPostRequest {
    static let shared : HandlingPostRequest = HandlingPostRequest()
    
    func callPostRequest() {
        // Prepare URL
        let url = URL(string: "https://ga-mobile-api.loklok.tv/cms/app/media/bathGetplayInfo")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.headers = HTTPAdditionalHeaders
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        
        let postString : [[String : Any]] = [
            [
                "category": 2,
                "contentId": "5959",
                "episodeId": 29804,
                "definition": "GROOT_LD"
            ]
        ]
        
        // Set HTTP Request Body
        request.httpBody = Data(json(from: postString)!.utf8)
        request.timeoutInterval = 20

        // Perform HTTP Request
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func postRequest() {
        let Url = String(format: "https://ga-mobile-api.loklok.tv/cms/app/media/bathGetplayInfo")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: Any] = [
            "category": 2,
            "contentId": "5959",
            "episodeId": 29804,
            "definition": "GROOT_LD"
        ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.headers = HTTPAdditionalHeaders
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func json(from object: [[String:Any]]) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object) else {
            return nil
        }
        
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
