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
    @Attribute(.unique) var id: String
    var stopID: String
    var routeNo: String
    var origin: TcEnSc
    var destination: TcEnSc
    
    init(id: String = UUID().uuidString, stopID: String, routeNo: String, origin: TcEnSc, destination: TcEnSc) {
        self.id = id
        self.stopID = stopID
        self.routeNo = routeNo
        self.origin = origin
        self.destination = destination
    }
}
