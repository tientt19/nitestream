//
//  APIError.swift
//  1SK
//
//  Created by tuyenvx on 9/30/20.
//

import Foundation

struct APIError: Error, Codable, CustomStringConvertible {
    var message: String
    var statusCode: Int

    init(message: String, statusCode: Int) {
        self.message = message
        self.statusCode = statusCode
    }

    var description: String {
        return "<APIError> code: \(statusCode), message: \(message)"
    }
}
