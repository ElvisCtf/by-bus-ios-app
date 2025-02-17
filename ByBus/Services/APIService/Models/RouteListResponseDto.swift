//
//  RouteListResponseDto.swift
//  ByBus
//
//  Created by Elvis Cheng on 20/1/2025.
//

import Foundation

// MARK: - RouteListResponseDto
struct RouteListResponseDto: Codable {
    let type, version: String?
    let generatedTimestamp: Date?
    let data: [Route]?

    enum CodingKeys: String, CodingKey {
        case type, version
        case generatedTimestamp = "generated_timestamp"
        case data
    }
}

// MARK: - Route
struct Route: Codable, Equatable {
    let company: Company?
    let routeNo: String?
    let origTc, origEn, origSc: String?
    let destTc, destEn, destSc: String?
    let dataTimestamp: Date?

    enum CodingKeys: String, CodingKey {
        case company = "co"
        case routeNo = "route"
        case origTc = "orig_tc"
        case origEn = "orig_en"
        case destTc = "dest_tc"
        case destEn = "dest_en"
        case origSc = "orig_sc"
        case destSc = "dest_sc"
        case dataTimestamp = "data_timestamp"
    }
}

enum Company: String, Codable {
    case ctb = "CTB"
    
    var zhName: String {
        switch self {
        case .ctb:
            return "城巴"
        }
    }
    
    var enName: String {
        switch self {
        case .ctb:
            return "Citybus"
        }
    }
}
