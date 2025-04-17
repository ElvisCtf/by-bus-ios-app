//
//  BusStop.swift
//  ByBus
//
//  Created by Elvis Cheng on 7/3/2025.
//

import MapKit

struct BusStop {
    let index: Int
    let id: String
    let routeNo: String
    let name: TcEnSc
    var etas: [String] = []
    
    var coordinate: CLLocationCoordinate2D?
    
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
        
        if let lat = stop.lat, let long = stop.long, let latitude = Double(lat), let longitude = Double(long) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        self.isSaved = isSaved
    }
}
