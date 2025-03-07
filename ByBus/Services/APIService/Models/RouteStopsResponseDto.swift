//
//  RouteStopsResponseDto.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

import Foundation

// MARK: - RouteStopsResponseDto
struct RouteStopsResponseDto: Codable {
    let type, version: String?
    let generatedTimestamp: Date?
    let routeStops: [RouteStop]?

    enum CodingKeys: String, CodingKey {
        case type, version
        case generatedTimestamp = "generated_timestamp"
        case routeStops = "data"
    }
}

// MARK: - RouteStop
struct RouteStop: Codable {
    let company: Company?
    let route: String?
    let direction: Direction?
    let sequence: Int?
    let id: String?
    let dataTimestamp: Date?

    enum CodingKeys: String, CodingKey {
        case company = "co"
        case route
        case direction = "dir"
        case sequence = "seq"
        case id = "stop"
        case dataTimestamp = "data_timestamp"
    }
}

enum Direction: String, Codable {
    case inbound = "I"
    case outbound = "O"
    
    var value: String {
        switch self {
        case .inbound:
            return "inbound"
        case .outbound:
            return "outbound"
        }
    }
    
    var toggle: Self {
        switch self {
        case .inbound:
            return .outbound
        case .outbound:
            return .inbound
        }
    }
}
