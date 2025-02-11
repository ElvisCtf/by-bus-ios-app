//
//  Data+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 11/2/2025.
//

import Foundation

extension Data {
    func decode<T: Decodable>(as type: T.Type) -> Result<T, Error> {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedObject = try decoder.decode(T.self, from: self)
            return .success(decodedObject)
        } catch let decodingError {
            return .failure(decodingError)
        }
    }
}
