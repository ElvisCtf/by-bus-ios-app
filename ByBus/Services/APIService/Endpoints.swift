//
//  Endpoints.swift
//  ByBus
//
//  Created by Elvis Cheng on 20/1/2025.
//

import Foundation

struct Endpoints {
    static let routes = URL(string: "https://rt.data.gov.hk/v2/transport/citybus/route/ctb")!
    static let stop = URL(string: "https://rt.data.gov.hk/v2/transport/citybus/stop")!
    static let routeStops = URL(string: "https://rt.data.gov.hk/v2/transport/citybus/route-stop/CTB")!
}
