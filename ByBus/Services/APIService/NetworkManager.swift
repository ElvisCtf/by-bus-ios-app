//
//  NetworkManager.swift
//  ByBus
//
//  Created by Elvis Cheng (ESD - Software Trainee, Digital Solutions) on 24/1/2025.
//

import Foundation
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()
    private let session: URLSession
    
    private init() {
        self.session = URLSession(configuration: .default)
    }
    
    func send<T: Decodable>(with request: URLRequest, as type: T.Type) -> Single<T> {
        return Single<T>.create { observer in
            let task = self.session.dataTask(with: request) { data, response, error in
                if let error {
                    observer(.failure(error))
                } else if let data {
                    observer(data.decode(as: T.self))
                } else {
                    observer(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
