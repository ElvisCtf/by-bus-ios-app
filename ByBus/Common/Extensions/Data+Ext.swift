//
//  Data+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 11/2/2025.
//

import Foundation

extension Data {
    func decode<T: Decodable>(as type: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedObject = try decoder.decode(T.self, from: self)
            return decodedObject
        } catch {
            return nil
        }
    }
}
