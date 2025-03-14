//
//  APIService.swift
//  ByBus
//
//  Created by Elvis Cheng on 21/1/2025.
//

import Foundation
import RxSwift

protocol APIServiceProtocol: AnyObject {
    func getRoutes(completion: @escaping (Result<RoutesResponseDto, Error>) -> Void)
    func getRouteStops(no: String, direction: String, completion: @escaping (Result<RouteStopsResponseDto, Error>) -> Void)
    func getStop(id: String, index: Int, completion: @escaping (Result<(StopResponseDto, Int), Error>) -> Void)
    func getEta(stopID: String, routeNo: String, completion: @escaping (Result<EtaResponseDto, Error>) -> Void)
}

final class APIService: APIServiceProtocol {
    private let disposeBag = DisposeBag()
    
    func getRoutes(completion: @escaping (Result<RoutesResponseDto, Error>) -> Void) {
        let request = APIRequest().make(with: Endpoints.routes)
        sendRequest(with: request, as: RoutesResponseDto.self, completion: completion)
    }
    
    func getRouteStops(no: String, direction: String, completion: @escaping (Result<RouteStopsResponseDto, Error>) -> Void) {
        let request = APIRequest(path: "\(no)/\(direction)").make(with: Endpoints.routeStops)
        sendRequest(with: request, as: RouteStopsResponseDto.self, completion: completion)
    }
    
    func getStop(id: String, index: Int, completion: @escaping (Result<(StopResponseDto, Int), Error>) -> Void) {
        let request = APIRequest(path: id).make(with: Endpoints.stop)
        NetworkManager.shared
            .send(with: request, as: StopResponseDto.self)
            .subscribe(onSuccess: { data in
                completion(.success((data, index)))
            },onFailure: { error in
                completion(.failure(error))
            })
            .disposed(by: disposeBag)
    }
    
    func getEta(stopID: String, routeNo: String, completion: @escaping (Result<EtaResponseDto, Error>) -> Void) {
        let request = APIRequest(path: "\(stopID)/\(routeNo)").make(with: Endpoints.estimatedTimeOfArrival)
        sendRequest(with: request, as: EtaResponseDto.self, completion: completion)
    }
    
    private func sendRequest<T: Codable>(with request: URLRequest, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        NetworkManager.shared
            .send(with: request, as: type.self)
            .subscribe(onSuccess: { data in
                completion(.success(data))
            },onFailure: { error in
                completion(.failure(error))
            })
            .disposed(by: disposeBag)
    }
}
