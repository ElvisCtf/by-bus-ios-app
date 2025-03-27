//
//  RoutesResponseDto.swift
//  ByBus
//
//  Created by Elvis Cheng on 20/1/2025.
//

import Foundation

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
    var origTc, origEn, origSc: String?
    var destTc, destEn, destSc: String?
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
        return TcEnSc(tc: origTc ?? "", en: origEn ?? "", sc: origSc ?? "")
    }
    
    var destination: TcEnSc {
        return TcEnSc(tc: destTc ?? "", en: destEn ?? "", sc: destSc ?? "")
    }
    
    mutating func switchDirection() {
        let temp = origin
        (origTc, origEn, origSc) = (destTc, destEn, destSc)
        (destTc, destEn, destSc) = (temp.tc, temp.en, temp.sc)
    }
}

// MARK: - Company
enum Company: String, Codable {
    case ctb = "CTB"
    
    var name: String {
        switch self {
        case .ctb:
            return String(localized: "citybus")
        }
    }
}

struct TcEnSc: Codable, Equatable {
    let tc: String
    let en: String
    let sc: String
    
    var value: String {
        let locale = Locale.current.identifier
        if locale.hasPrefix("zh-Hant") {
            return tc
        } else if locale.hasPrefix("en") {
            return en
        } else if locale.hasPrefix("zh-Hans") {
            return sc
        }
        return tc
    }
}
