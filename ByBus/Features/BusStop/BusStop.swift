//
//  BusStop.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

struct BusStop {
    let index: Int
    let name: String
    var arriveTimeList: [String] = []
    var isExpanded = false
    
    var arriveTime: String {
        arriveTimeList.joined(separator: "\n\n")
    }
}
