//
//  BusStop.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

struct BusStop {
    let index: Int
    let id: String
    let routeNo: String
    let name: TcEnSc
    var etas: [String] = []
    var isExpanded = false
    var isSaved: Bool
    
    var arrivalTime: String {
        "\(etas.joined(separator: "\n\n"))"
    }
    
    init(index: Int, routeNo: String, stop: Stop, isSaved: Bool = false) {
        self.index = index
        self.id = stop.id ?? ""
        self.routeNo = routeNo
        self.name = stop.name
        self.isSaved = isSaved
    }
}
