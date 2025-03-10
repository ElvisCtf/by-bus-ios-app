//
//  APIService.swift
//  ByBus
//
//  Created by Elvis Cheng on 21/1/2025.
//

import Foundation
import RxSwift

protocol APIServiceProtocol: AnyObject {
    func getRoutes(completion: @escaping (Bool, RoutesResponseDto?, Error?) -> Void)
    func getRouteStops(no: String, direction: String, completion: @escaping (Bool, RouteStopsResponseDto?, Error?) -> Void)
    func getStop(id: String, index: Int, completion: @escaping (Bool, StopResponseDto?, Int, Error?) -> Void)
    func getEta(stopID: String, routeNo: String, completion: @escaping (Bool, EtaResponseDto?, Error?) -> Void)
}

final class APIService: APIServiceProtocol {
    private let disposeBag = DisposeBag()
    
    func getRoutes(completion: @escaping (Bool, RoutesResponseDto?, Error?) -> Void) {
        let request = APIRequest().make(with: Endpoints.routes)
        NetworkManager.shared
            .send(with: request, as: RoutesResponseDto.self)
            .subscribe(onSuccess: { data in
                completion(true, data, nil)
            },onFailure: { error in
                completion(false, nil, error)
            })
            .disposed(by: disposeBag)
    }
    
    func getRouteStops(no: String, direction: String, completion: @escaping (Bool, RouteStopsResponseDto?, Error?) -> Void) {
        let request = APIRequest(path: "\(no)/\(direction)").make(with: Endpoints.routeStops)
        NetworkManager.shared
            .send(with: request, as: RouteStopsResponseDto.self)
            .subscribe(onSuccess: { data in
                completion(true, data, nil)
            },onFailure: { error in
                completion(false, nil, error)
            })
            .disposed(by: disposeBag)
    }
    
    func getStop(id: String, index: Int, completion: @escaping (Bool, StopResponseDto?, Int, Error?) -> Void) {
        let request = APIRequest(path: id).make(with: Endpoints.stop)
        NetworkManager.shared
            .send(with: request, as: StopResponseDto.self)
            .subscribe(onSuccess: { data in
                completion(true, data, index, nil)
            },onFailure: { error in
                completion(false, nil, index, error)
            })
            .disposed(by: disposeBag)
    }
    
    func getEta(stopID: String, routeNo: String, completion: @escaping (Bool, EtaResponseDto?, Error?) -> Void) {
        let request = APIRequest(path: "\(stopID)/\(routeNo)").make(with: Endpoints.estimatedTimeOfArrival)
        NetworkManager.shared
            .send(with: request, as: EtaResponseDto.self)
            .subscribe(onSuccess: { data in
                completion(true, data, nil)
            },onFailure: { error in
                completion(false, nil, error)
            })
            .disposed(by: disposeBag)
    }
}
