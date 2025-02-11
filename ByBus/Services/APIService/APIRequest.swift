//
//  APIRequest.swift
//  ByBus
//
//  Created by Elvis Cheng on 11/2/2025.
//

import Foundation

struct APIRequest {
    var method: RequestType = .GET
    var path: String = ""
    var parameters: [String:String] = [:]
    
    func make(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

enum RequestType: String {
    case GET, POST
}
