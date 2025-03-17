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
    var isSaved = false
    
    var arrivalTime: String {
        "\n\(etas.joined(separator: "\n\n"))\n"
    }
    
    init(index: Int, routeNo: String, stop: Stop) {
        self.index = index
        self.id = stop.id ?? ""
        self.routeNo = routeNo
        self.name = stop.name
    }
}
