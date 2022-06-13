//
//  InternetConnection.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 13/06/2022.
//

import Foundation
import Reachability

class InternetConnection {
    static let shared = InternetConnection()
    private var reachability: Reachability?
    
    private init() {
        self.setupDefaults()
    }

    func isAvailable() -> Bool {
        guard let reachability = try? Reachability() else {
            return false
        }
        return reachability.connection != .unavailable
    }

    private func setupDefaults() {
        self.reachability = try? Reachability()
        self.reachability?.whenReachable = { _ in
            NotificationCenter.default.post(name: .connectionAvailable, object: nil)
        }

        self.reachability?.whenUnreachable = { _ in
            NotificationCenter.default.post(name: .connectionUnavailable, object: nil)
        }
    }

    func startNotifier() {
        try? self.reachability?.startNotifier()
    }
}
