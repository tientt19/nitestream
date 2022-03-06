//
//  Model.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 19/02/2022.
//


//{
//    "albumId": 10,
//    "id": 451,
//    "title": "dolorem accusantium corrupti incidunt quas ex est",
//    "url": "https://via.placeholder.com/600/5e912a",
//    "thumbnailUrl": "https://via.placeholder.com/150/5e912a"
//  },

import Foundation

class MainModel {
    var albumId : Int = 0
    var id: Int = 0
    var title: String = ""
    var url: String = ""
    var thumbnailUrl: String = ""
    
    func initLoad(_ json: [String: Any]) -> MainModel{
        if let temp = json["albumId"] as? Int { albumId = temp }
        if let temp = json["id"] as? Int { id = temp }
        if let temp = json["title"] as? String { title = temp }
        if let temp = json["url"] as? String { url = temp }
        if let temp = json["thumbnailUrl"] as? String { thumbnailUrl = temp }
        return self
    }
}
