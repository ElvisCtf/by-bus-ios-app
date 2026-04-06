//
//  NetworkManager.swift
//  ByBus
//
//  Created by Elvis Cheng on 24/1/2025.
//

import Foundation
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()
    private let session: URLSession
    
    private init() {
        self.session = URLSession(configuration: .default)
    }
    
    func asyncSend<T: Decodable>(with request: URLRequest, as type: T.Type) async -> Result<T, Error> {
        do {
            let (data, _) = try await session.data(for: request)
            if let data = data.decode(as: T.self) {
                return .success(data)
            } else {
                return .failure(NSError(domain: "Nil data", code: -1, userInfo: nil))
            }
        } catch {
            return .failure(error)
        }
        
    }
}
