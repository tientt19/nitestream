//
//  Result.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 30/05/2022.
//

import Foundation

extension Result where Success: Codable {
    func unwrapSuccessModel<T>() -> Result<T, Failure> where Success == BaseModel<T>, Failure == APIError {
        return flatMap { (baseModel) -> Result<T, Failure> in
            if let data = baseModel.data {
                return .success(data)
            } else {
                let apiError = APIError(message: "Can not unwrap optional \(T.self)", statusCode: -1)
                return .failure(apiError)
            }
        }
    }
}
