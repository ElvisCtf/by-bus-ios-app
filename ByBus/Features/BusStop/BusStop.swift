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
    let nameTc, nameEn, nameSc: String
    var etas: [String] = []
    var isExpanded = false
    
    var arrivalTime: String {
        etas.joined(separator: "\n\n")
    }
    
    init(index: Int, routeNo: String, stop: Stop) {
        self.index = index
        self.id = stop.id ?? ""
        self.routeNo = routeNo
        self.nameTc = stop.nameTc ?? ""
        self.nameEn = stop.nameEn ?? ""
        self.nameSc = stop.nameSc ?? ""
    }
}
