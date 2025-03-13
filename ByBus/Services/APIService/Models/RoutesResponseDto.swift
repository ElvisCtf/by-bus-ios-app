//
//  RoutesResponseDto.swift
//  ByBus
//
//  Created by Elvis Cheng on 20/1/2025.
//

import Foundation

typealias TcEnSc = (String, String, String)

// MARK: - RoutesResponseDto
struct RoutesResponseDto: Codable {
    let type, version: String?
    let generatedTimestamp: Date?
    let routes: [Route]?

    enum CodingKeys: String, CodingKey {
        case type, version
        case generatedTimestamp = "generated_timestamp"
        case routes = "data"
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
    
    var origin: TcEnSc {
        return (origTc ?? "", origEn ?? "", origSc ?? "")
    }
    
    var destination: TcEnSc {
        return (destEn ?? "", destTc ?? "", destSc ?? "")
    }
}

// MARK: - Company
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
