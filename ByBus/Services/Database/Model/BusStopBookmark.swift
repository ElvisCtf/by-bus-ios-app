//
//  BusStopBookmark.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import SwiftData
import Foundation

@Model
final class BusStopBookmark {
    @Attribute(.unique) var id: UUID = UUID()
    var stopID: String
    var routeNo: String
    var origin: TcEnSc
    var destination: TcEnSc
    var name: TcEnSc
    
    init(stopID: String, routeNo: String, origin: TcEnSc, destination: TcEnSc, name: TcEnSc) {
        self.stopID = stopID
        self.routeNo = routeNo
        self.origin = origin
        self.destination = destination
        self.name = name
    }
}
