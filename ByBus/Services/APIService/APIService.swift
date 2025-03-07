//
//  APIService.swift
//  ByBus
//
//  Created by Elvis Cheng on 21/1/2025.
//

import Foundation
import RxSwift

protocol APIServiceProtocol: AnyObject {
    func getRouteList(completion: @escaping (Bool, RoutesResponseDto?, Error?) -> Void)
}

final class APIService: APIServiceProtocol {
    private let disposeBag = DisposeBag()
    
    func getRouteList(completion: @escaping (Bool, RoutesResponseDto?, Error?) -> Void) {
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
}
