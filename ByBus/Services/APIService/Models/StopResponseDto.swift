//
//  StopResponseDto.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

import Foundation

// MARK: - StopResponseDto
struct StopResponseDto: Codable {
    let type, version: String?
    let generatedTimestamp: Date?
    let stop: Stop?

    enum CodingKeys: String, CodingKey {
        case type, version
        case generatedTimestamp = "generated_timestamp"
        case stop = "data"
    }
}

// MARK: - Stop
struct Stop: Codable {
    let id, nameTc, nameEn, nameSc: String?
    let lat, long: String?
    let dataTimestamp: Date?

    enum CodingKeys: String, CodingKey {
        case id = "stop"
        case nameTc = "name_tc"
        case nameEn = "name_en"
        case nameSc = "name_sc"
        case lat, long
        case dataTimestamp = "data_timestamp"
    }
}
