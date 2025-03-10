//
//  EtaResponseDto.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import Foundation

// MARK: - EtaResponseDto
struct EtaResponseDto: Codable {
    let type, version: String?
    let generatedTimestamp: Date?
    let etas: [EstimatedTimeOfArrival]?

    enum CodingKeys: String, CodingKey {
        case type, version
        case generatedTimestamp = "generated_timestamp"
        case etas = "data"
    }
}

// MARK: - EstimatedTimeOfArrival
struct EstimatedTimeOfArrival: Codable {
    let company: Company?
    let route, direction: String?
    let sequence: Int?
    let stop, destTc, destSc, destEn: String?
    let etaSeq: Int?
    let time: Date?
    let rmkTc, rmkSc, rmkEn: String?
    let dataTimestamp: Date?

    enum CodingKeys: String, CodingKey {
        case company = "co"
        case route
        case direction = "dir"
        case sequence = "seq"
        case stop
        case destTc = "dest_tc"
        case destSc = "dest_sc"
        case destEn = "dest_en"
        case etaSeq = "eta_seq"
        case time = "eta"
        case rmkTc = "rmk_tc"
        case rmkSc = "rmk_sc"
        case rmkEn = "rmk_en"
        case dataTimestamp = "data_timestamp"
    }
}
