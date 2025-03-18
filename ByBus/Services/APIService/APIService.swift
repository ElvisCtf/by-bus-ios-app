//
//  APIService.swift
//  ByBus
//
//  Created by Elvis Cheng on 21/1/2025.
//

import Foundation
import RxSwift

protocol APIServiceProtocol: AnyObject {
    func getRoutes() async -> Result<RoutesResponseDto, Error>
    func getRouteStops(no: String, direction: String) async -> Result<RouteStopsResponseDto, Error>
    func getStop(id: String, index: Int) async -> (Int, Result<StopResponseDto, Error>)
    func getEta(stopID: String, routeNo: String) async -> Result<EtaResponseDto, Error>
}

final class APIService: APIServiceProtocol {
    private let disposeBag = DisposeBag()
    
    func getRoutes() async -> Result<RoutesResponseDto, Error> {
        let request = APIRequest().make(with: Endpoints.routes)
        return await NetworkManager.shared.asyncSend(with: request, as: RoutesResponseDto.self)
    }
    
    func getRouteStops(no: String, direction: String) async -> Result<RouteStopsResponseDto, Error> {
        let request = APIRequest(path: "\(no)/\(direction)").make(with: Endpoints.routeStops)
        return await NetworkManager.shared.asyncSend(with: request, as: RouteStopsResponseDto.self)
    }
    
    func getStop(id: String, index: Int) async -> (Int, Result<StopResponseDto, Error>) {
        let request = APIRequest(path: id).make(with: Endpoints.stop)
        return (index, await NetworkManager.shared.asyncSend(with: request, as: StopResponseDto.self))
    }
    
    func getEta(stopID: String, routeNo: String) async -> Result<EtaResponseDto, Error> {
        let request = APIRequest(path: "\(stopID)/\(routeNo)").make(with: Endpoints.estimatedTimeOfArrival)
        return await NetworkManager.shared.asyncSend(with: request, as: EtaResponseDto.self)
    }

}
